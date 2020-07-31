using System.Composition;
using Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills;
using FusionFramework.EntityFramework.Mapping.EntityMapping;
using FusionFramework.EntityFramework.Mapping.Strategy;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Infrastructure.Mapping.Warehouse.Models.Bill.ManualMaterialBills
{
    [Export(typeof(IEntityMapping))]
    public class ManualMaterialBillMap : EntityMappingBase<ManualMaterialBill>, IEntityMapping
    {
        [Import("default-t", AllowDefault = true)]
        public override IMappingStrategy TableNameMappingStrategy { get; set; }
        public override void Init()
        {
            this.TablePrefix = "WM_";
            base.Init();

            this.HasKey(t => t.ManualMaterialBillNo);

            this.Property(t => t.ManualMaterialBillNo)
                .HasMaxLength(32);

            this.Property(t => t.OriginPlanNo)
                .HasMaxLength(32);

            this.Property(t => t.PlanBeginTime)
                .IsRequired();

            this.Property(t => t.PlanEndTime)
                    .IsRequired();

            this.Property(t => t.ManualMaterialBillStatus)
                .IsRequired();

            this.Property(t => t.BillNo)
                .HasMaxLength(32);

            this.Property(t => t.Maker)
                .IsRequired()
                .HasMaxLength(50);

            this.Property(t => t.MakeTime)
                .IsRequired();

            this.Property(t => t.Auditor)
                .HasMaxLength(50);

            this.Property(t => t.AuditTime);

            this.Property(t => t.CreateTime)
                .IsRequired();

            this.Property(t => t.UpdateTime)
                .IsRequired();

            this.Property(t => t.RowVersion)
                .HasMaxLength(50)
                .IsConcurrencyToken();
        }
    }
}
