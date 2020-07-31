using System;
using Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Context.Warehouse.Application.Models.Bill.ManualMaterialBills
{
    public class ManualMaterialBillDetailModel
    {
        public Guid Id { get; set; }
        public int SerialNumber { get; set; }
        public string ManualMaterialBillNo { get; set; }
        public string TeamCode { get; set; }
        public string TeamName { get; set; }
        public string MachineCode { get; set; }
        public string MachineName { get; set; }
        /// <summary>
        /// 班次，1:夜,2:白,3:中
        /// </summary>
        public string ShiftCode { get; private set; }
        public string ShiftName { get; private set; }
        public string BrandCode { get; set; }
        public string BrandName { get; set; }
        public string OriginWorkNo { get; set; }
        public ManualMaterialBillDetailStatus ManualMaterialBillDetailStatus { get; set; }
        public DateTime ? ProductionBeginTime { get; set; }
        public DateTime ? ProductionEndTime { get; set; }
        public DateTime CreateTime { get; set; }
        public DateTime UpdateTime { get; set; }
        public byte[] RowVersion { get; set; }

        public string ManualMaterialBillDetailStatusName { get; set; }
    }
}
