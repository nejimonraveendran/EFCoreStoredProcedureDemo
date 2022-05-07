using EfSpDemo.Data.Config;
using Microsoft.EntityFrameworkCore;

namespace EfSpDemo.Data
{
    public class ProductsDbContext : DbContext
    {
        public ProductsDbContext()
        {

        }

        //constructor to be called from the project that consumes the DbContext.  With the dbContextOptions, the invoking project can pass in configuration such as connection string.
        public ProductsDbContext(DbContextOptions dbContextOptions) : base(dbContextOptions)
        {
            this.ChangeTracker.LazyLoadingEnabled = false;
            this.ChangeTracker.AutoDetectChangesEnabled = false;
        }

        
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfiguration(new CategoryConfig());
            modelBuilder.ApplyConfiguration(new ProductConfig());

            modelBuilder.ApplyConfiguration(new ProductResultConfig());

        }
    }
}