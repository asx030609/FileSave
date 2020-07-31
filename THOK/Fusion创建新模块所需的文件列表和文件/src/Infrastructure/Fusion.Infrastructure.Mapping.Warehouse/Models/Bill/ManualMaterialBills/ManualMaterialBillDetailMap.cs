using System.Composition;
using System.Data.Entity.ModelConfiguration.Configuration;
using Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills;
using FusionFramework.EntityFramework.Mapping.EntityMapping;
using FusionFramework.EntityFramework.Mapping.Strategy;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Infrastructure.Mapping.Warehouse.Models.Bill.ManualMaterialBills
{
    [Export(typeof(IEntityMapping))]
    public class ManualMaterialBillDetailMap : EntityMappingBase<ManualMaterialBillDetail>, IEntityMapping
    {
        [Import("default-t", AllowDefault = true)]
        public override IMappingStrategy TableNameMappingStrategy { get; set; }
        public override void Init()
        {
            this.TablePrefix = "WM_";
            base.Init();

            this.HasKey(t => new { t.Id, t.ManualMaterialBillNo });

            this.Property(t => t.SerialNumber)
                .IsRequired();

            this.Property(t => t.ManualMaterialBillNo)
                .HasMaxLength(32);

            this.Property(t => t.TeamCode)
                .HasMaxLength(32)
                .IsRequired();

            this.Property(t => t.TeamName)
                .HasMaxLength(50)
                .IsRequired();

            this.Property(t => t.ShiftCode)
                .HasMaxLength(32);

            this.Property(t => t.ShiftName)
                .HasMaxLength(50);

            this.Property(t => t.MachineCode)
                .IsRequired()
                .HasMaxLength(32);

            this.Property(t => t.MachineName)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.BrandCode)
                .IsRequired()
                .HasMaxLength(32);

            this.Property(t => t.BrandName)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.OriginWorkNo)
                .HasMaxLength(32);

            this.Property(t => t.ManualMaterialBillDetailStatus)
                .IsRequired();

            this.Property(t => t.ProductionBeginTime);

            this.Property(t => t.ProductionEndTime);

            this.Property(t => t.CreateTime)
                .IsRequired();

            this.Property(t => t.UpdateTime)
                .IsRequired();

            this.Property(t => t.RowVersion)
                .HasMaxLength(50).IsConcurrencyToken();

            this.HasRequired(t => t.ManualMaterialBill)
                .WithMany(t => t.ManualMaterialBillDetails)
                .HasForeignKey(t => t.ManualMaterialBillNo);
        }
    }
}
