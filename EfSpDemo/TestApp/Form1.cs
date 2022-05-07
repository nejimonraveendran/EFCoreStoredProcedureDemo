using EfSpDemo.Data;
using EfSpDemo.Data.Entities;
using EfSpDemo.Data.ResultSets;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace TestApp
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            var cnString = "Server=.;Database=ProductsDb;Integrated Security=true;";

            var optionsBuilder = new DbContextOptionsBuilder<ProductsDbContext>();
            optionsBuilder.UseSqlServer(cnString);

            using (var context = new ProductsDbContext(optionsBuilder.Options))
            {
                //add using linq
                var reference = context.Set<Product>().Add(new Product { ProductName = "My New EF Product", CategoryId = 1 });
                context.SaveChanges();

                Product product = reference.Entity;

                //query using linq
                var products = context.Set<Product>()
                                        .Include(x => x.Category)
                                        .Where(x => x.Id == product.Id)
                                        .ToList();

                //delete using linq
                context.Set<Product>().Remove(product);
                context.SaveChanges();



                ////insert using stored proc
                var newProductNameParam = new SqlParameter("@ProductName", SqlDbType.NVarChar) { Value = "My New SP Product" };
                var categoryIdParam = new SqlParameter("@CategoryId", SqlDbType.Int) { Value = 2 };
                var ReturnedProductIdParam = new SqlParameter("@ReturnedProductId", SqlDbType.Int) { Direction = ParameterDirection.Output };
                var rowsInserted = context.Database.ExecuteSqlRaw("SP_InsertProduct @ProductName={0}, @CategoryId={1}, @ReturnedProductId={2} OUTPUT", newProductNameParam, categoryIdParam, ReturnedProductIdParam);

                //retrieve the id of just inserted record
                int IdOfNewlyInsertedProduct = Convert.ToInt32(ReturnedProductIdParam.Value);

                //query using stored proc
                var result2 = context.Set<ProductResult>().FromSqlRaw("exec SP_GetAllProducts").ToList(); //select p.Id ProductId, p.ProductName, c.CategoryName from products p inner join categories c on p.CategoryId=c.id

                //query using raw sql + linq but still taking advantage of the filtering done within sql server before bringing the results to the application.
                var resultFiltered = context.Set<ProductResult>().FromSqlRaw("select p.Id ProductId, p.ProductName, c.Id CategoryId, c.CategoryName from products p inner join categories c on p.CategoryId=c.id")
                                        .Where(x => x.ProductId == IdOfNewlyInsertedProduct).ToList(); 

                //delete using stored proc
                var rowsDeleted = context.Database.ExecuteSqlInterpolated($"delete from Products where Id ={IdOfNewlyInsertedProduct}");


            }

        }
    }
}