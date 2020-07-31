using System;
using System.Collections.Generic;
using Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Context.Warehouse.Application.Models.Bill.ManualMaterialBills
{
    public class ManualMaterialBillModel
    {
        public string ManualMaterialBillNo { get; set; }
        public string OriginPlanNo { get; set; }
        public DateTime PlanBeginTime { get; set; }
        public DateTime PlanEndTime { get; set; }
        public string BillNo { get; set; }
        public string Maker { get; set; }
        public DateTime MakeTime { get; set; }
        public string Auditor { get; set; }
        public DateTime? AuditTime { get; set; }
        public ManualMaterialBillStatus ManualMaterialBillStatus { get; set; }
        public DateTime CreateTime { get; set; }
        public DateTime UpdateTime { get; set; }
        public byte[] RowVersion { get; set; }

        public string TeamCode { get; set; }
        public string TeamName { get; set; }
        public string MachineCode { get; set; }
        public string MachineName { get; set; }
        public string BrandName { get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? FinishTime { get; set; }

        public string ManualMaterialBillStatusName { get; set; }
        public IList<ManualMaterialBillDetailModel> ManualMaterialBillDetails { get; set; }
    }
}
