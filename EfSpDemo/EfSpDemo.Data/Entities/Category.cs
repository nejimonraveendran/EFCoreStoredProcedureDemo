using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EfSpDemo.Data.Entities
{
    public class Category
    {
        public Category()
        {
            this.Products = new List<Product>();    
        }

        public int Id { get; set; }
        public string CategoryName { get; set; }
        public virtual ICollection<Product> Products { get; set; }

    }
}
