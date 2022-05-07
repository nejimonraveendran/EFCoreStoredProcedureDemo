using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EfSpDemo.Data.Config
{
    internal class ProductResultConfig : IEntityTypeConfiguration<ProductResult>
    {
        public void Configure(EntityTypeBuilder<ProductResult> builder)
        {
            builder.HasNoKey();

        }
    }
}
