using System;
using System.Linq;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills
{
    public class ManualMaterialBillDetail
    {
        public ManualMaterialBillDetail() { }

        public ManualMaterialBillDetail(
            string brandCode, string brandName,
            string machineCode, string machineName,
            string teamCode, string teamName,
            string originWorkNo,
            string shiftCode = "", string shiftName="")
        {
            this.Id = Guid.NewGuid();
            this.BrandCode = brandCode;
            this.BrandName = brandName;
            this.MachineCode = machineCode;
            this.MachineName = machineName;
            this.TeamCode = teamCode;
            this.TeamName = teamName;
            this.OriginWorkNo = originWorkNo;
            this.ShiftCode = shiftCode;
            this.ShiftName = shiftName;
        }

        public ManualMaterialBillDetail(
            string manualMaterialBillNo,
            int serialNumber,
            string teamCode,
            string teamName,
            string machineCode,
            string machineName,
            string brandCode,
            string brandName)
        {
            this.Id = Guid.NewGuid();
            this.ManualMaterialBillNo = manualMaterialBillNo;
            this.SerialNumber = serialNumber;
            this.TeamCode = teamCode;
            this.TeamName = teamName;
            this.MachineCode = machineCode;
            this.MachineName = machineName;
            this.BrandCode = brandCode;
            this.BrandName = brandName;
            this.ManualMaterialBillDetailStatus = 0;
            this.CreateTime = DateTime.Now;
            this.UpdateTime = DateTime.Now;
        }

        public Guid Id { get; private set; }
        public int SerialNumber { get; private set; }
        public string ManualMaterialBillNo { get; private set; }
        public string TeamCode { get; private set; }
        public string TeamName { get; private set; }
        /// <summary>
        /// 班次，1:夜,2:白,3:中
        /// </summary>
        public string ShiftCode { get; private set; }
        public string ShiftName { get; private set; }
        public string MachineCode { get; private set; }
        public string MachineName { get; private set; }
        public string BrandCode { get; private set; }
        public string BrandName { get; private set; }
        public string OriginWorkNo { get; private set; }
        public ManualMaterialBillDetailStatus ManualMaterialBillDetailStatus { get; set; }
        public DateTime? ProductionBeginTime { get; set; }
        public DateTime? ProductionEndTime { get; set; }
        public DateTime CreateTime { get; set; }
        public DateTime UpdateTime { get; set; }
        public byte[] RowVersion { get; set; }

        public virtual ManualMaterialBill ManualMaterialBill { get; private set; }

        public void Modify(ManualMaterialBillDetail manualMaterialBillDetail)
        {
            if (this.RowVersion.Except(manualMaterialBillDetail.RowVersion).Count() > 0)
            {
                throw new Exception("记录已被修改，请刷新！");
            }

            this.TeamCode = manualMaterialBillDetail.TeamCode;
            this.TeamName = manualMaterialBillDetail.TeamName;
            this.MachineCode = manualMaterialBillDetail.MachineCode;
            this.MachineName = manualMaterialBillDetail.MachineName;
            this.BrandCode = manualMaterialBillDetail.BrandCode;
            this.BrandName = manualMaterialBillDetail.BrandName;
            this.OriginWorkNo = manualMaterialBillDetail.OriginWorkNo;
            this.ManualMaterialBillDetailStatus = manualMaterialBillDetail.ManualMaterialBillDetailStatus;
        }

        public void ModifyManualMaterialBillDetailStatus(ManualMaterialBillDetailStatus status, DateTime time)
        {
            switch (Convert.ToInt32(status))
            {
                case 1:
                    this.ProductionBeginTime = time;
                    break;
                case 2:
                    this.ProductionEndTime = time;
                    break;
            }
            this.ManualMaterialBillDetailStatus = status;
        }

        public void Modify(ManualMaterialBillDetailStatus ManualMaterialBillDetailStatus)
        {
            this.ManualMaterialBillDetailStatus = ManualMaterialBillDetailStatus;
        }

        public bool IsCompleted()
        {
            return this.ManualMaterialBillDetailStatus == ManualMaterialBillDetailStatus.Complete;
        }

        public bool IsChangeShift()
        {
            return this.ManualMaterialBillDetailStatus == ManualMaterialBillDetailStatus.ChangeShift;
        }

        public bool IsChangeBrand()
        {
            return this.ManualMaterialBillDetailStatus == ManualMaterialBillDetailStatus.ChangeBrand;
        }

        internal void TryProduction()
        {
            if (this.ManualMaterialBillDetailStatus != ManualMaterialBillDetailStatus.Wait)
            {
                return;
            }

            this.ManualMaterialBillDetailStatus = ManualMaterialBillDetailStatus.Production;
            this.ProductionBeginTime = DateTime.Now;
        }

        internal void Complete()
        {
            this.ManualMaterialBillDetailStatus = ManualMaterialBillDetailStatus.Complete;
            this.ProductionEndTime = DateTime.Now;
        }

        internal void SetSerialNumber(int serialNumber)
        {
            this.SerialNumber = serialNumber;
        }
        internal void Production()
        {
            this.ManualMaterialBillDetailStatus = ManualMaterialBillDetailStatus.Production;
        }

        internal void ChangeShift()
        {
            this.ManualMaterialBillDetailStatus = ManualMaterialBillDetailStatus.ChangeShift;
        }

        internal void ChangeBrand()
        {
            this.ManualMaterialBillDetailStatus = ManualMaterialBillDetailStatus.ChangeBrand;
        }
    }
}
