using System;
using System.Collections.Generic;
using System.Linq;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills
{
    public class ManualMaterialBill
    {
        public ManualMaterialBill() { }

        public ManualMaterialBill(
            string producationPlanNo,
            DateTime planBeginTime,
            DateTime planEndTime,
            string maker)
        {
            this.ManualMaterialBillNo = producationPlanNo;
            this.PlanBeginTime = planBeginTime;
            this.PlanEndTime = planEndTime;
            this.ManualMaterialBillStatus = ManualMaterialBillStatus.Entered;
            this.Maker = maker;
            this.MakeTime = DateTime.Now;
            this.ManualMaterialBillDetails = new List<ManualMaterialBillDetail>();
        }

        public string ManualMaterialBillNo { get; private set; }
        public string OriginPlanNo { get; private set; }
        public DateTime PlanBeginTime { get; private set; }
        public DateTime PlanEndTime { get; private set; }
        public string Maker { get; private set; }
        public DateTime MakeTime { get; private set; } = DateTime.Now;
        public string Auditor { get; private set; }
        public string BillNo { get; private set; }
        public DateTime? AuditTime { get; private set; }
        public ManualMaterialBillStatus ManualMaterialBillStatus { get; private set; }
        public DateTime CreateTime { get; set; }
        public DateTime UpdateTime { get; set; }
        public byte[] RowVersion { get; set; }

        public virtual ICollection<ManualMaterialBillDetail> ManualMaterialBillDetails { get; set; } = new List<ManualMaterialBillDetail>();

        public void Modify(ManualMaterialBill manualMaterialBill)
        {
            if (this.RowVersion.Except(manualMaterialBill.RowVersion).Count() > 0)
            {
                throw new Exception("记录已被修改，请刷新！");
            }

            this.PlanBeginTime = manualMaterialBill.PlanBeginTime;
            this.PlanEndTime = manualMaterialBill.PlanEndTime;
            this.ManualMaterialBillStatus = manualMaterialBill.ManualMaterialBillStatus;
            this.Maker = manualMaterialBill.Maker;
            this.MakeTime = DateTime.Now;
            this.UpdateTime = DateTime.Now;
        }

        public void Verify(string auditor)
        {
            if (this.ManualMaterialBillDetails.Count <= 0)
            {
                throw new Exception($"WMS 的生产计划单号：{ManualMaterialBillNo} MES 批次号：{ OriginPlanNo }没有明细无法审核！");
            }
            this.Auditor = auditor;
            this.AuditTime = DateTime.Now;
            this.ManualMaterialBillStatus = ManualMaterialBillStatus.Audited;
            this.UpdateTime = DateTime.Now;
        }

        public void TryVerify(string auditor)
        {
            if (this.ManualMaterialBillStatus >= ManualMaterialBillStatus.Audited)
            {
                return;
            }

            this.Verify(auditor);
        }

        public void Reverify()
        {
            if (this.ManualMaterialBillStatus != ManualMaterialBillStatus.Audited)
            {
                throw new Exception("所选择的行没有已审核状态的单据！无法反审！");
            }
            this.Auditor = null;
            this.AuditTime = null;
            this.ManualMaterialBillStatus = ManualMaterialBillStatus.Entered;
            this.UpdateTime = DateTime.Now;
        }

        public void Task()
        {
            if (this.ManualMaterialBillStatus != ManualMaterialBillStatus.Audited && this.ManualMaterialBillStatus != ManualMaterialBillStatus.Executing)
            {
                throw new Exception("所选择的行没有已审核状态的单据！无法作业！");
            }
            this.ManualMaterialBillStatus = ManualMaterialBillStatus.Executing;
            this.UpdateTime = DateTime.Now;
        }

        public void TryTask()
        {
            if (this.ManualMaterialBillStatus >= ManualMaterialBillStatus.Executing)
            {
                return;
            }

            this.Task();
        }

        public void Settle()
        {
            if (this.ManualMaterialBillStatus != ManualMaterialBillStatus.Executing)
            {
                throw new Exception($"生产计划号：{ManualMaterialBillNo}不是执行中状态，不能结单；请检查！");
            }

            if (this.ManualMaterialBillDetails.Any(it =>
                it.ManualMaterialBillDetailStatus == ManualMaterialBillDetailStatus.Production))
            {
                throw new Exception($"生产计划号：{ManualMaterialBillNo}存在生产中任务，不能结单；请检查！");
            }

            this.ManualMaterialBillStatus = ManualMaterialBillStatus.Settled;
            this.UpdateTime = DateTime.Now;
        }

        public void AdjustBeginEndTime(DateTime beginTime,DateTime endTime)
        {
            this.PlanBeginTime = beginTime;
            this.PlanEndTime = endTime;
        }
        #region ManualMaterialBillDetail
        public ManualMaterialBillDetail AddManualMaterialBillDetail(string maker, ManualMaterialBillDetail manualMaterialBillDetail)
        {
            this.ManualMaterialBillDetails.Add(manualMaterialBillDetail);
            this.Maker = maker;
            this.MakeTime = DateTime.Now;

            return manualMaterialBillDetail;
        }

        public void ModifyManualMaterialBillDetail(string maker, ManualMaterialBillDetail manualMaterialBillDetail)
        {
            var entity = this.GetManualMaterialBillDetail(manualMaterialBillDetail.Id);
            var isExistMachineCodeAndStatusOfWait = this.ManualMaterialBillDetails.Any(b => b.MachineCode == manualMaterialBillDetail.MachineCode
                                                           && b.ManualMaterialBillDetailStatus == ManualMaterialBillDetailStatus.Wait
                                                           && b.Id != manualMaterialBillDetail.Id);

            if (isExistMachineCodeAndStatusOfWait)
            {
                throw new Exception($"生产计划号：{ManualMaterialBillNo}机组：{manualMaterialBillDetail.MachineName}存在等待中的生产计划，不能修改；请检查！");
            }

            entity.Modify(manualMaterialBillDetail);

            this.Maker = maker;
            this.MakeTime = DateTime.Now;
        }

        public void RemoveManualMaterialBillDetail(string maker, Guid[] manualMaterialBillDetailIds)
        {
            var entities = this.ManualMaterialBillDetails
                .Where(f => manualMaterialBillDetailIds.Contains(f.Id)).ToArray();

            for (int i = 0; i < entities.Count(); i++)
            {
                this.ManualMaterialBillDetails.Remove(entities[i]);
            }

            this.Maker = maker;
            this.MakeTime = DateTime.Now;
        }

        public void ModifyManualMaterialBillDetailStatus(ManualMaterialBillDetail manualMaterialBillDetail, bool? isWork = null)
        {
            var entity = this.ManualMaterialBillDetails.FirstOrDefault(t => t.MachineCode == manualMaterialBillDetail.MachineCode);
            if (entity == null)
            {
                throw new Exception($"生产计划明细牌号:{manualMaterialBillDetail.BrandCode}【{manualMaterialBillDetail.BrandName}】，不存在；请刷新！");
            }
            if (isWork == null)
            {
                entity.ModifyManualMaterialBillDetailStatus(manualMaterialBillDetail.ManualMaterialBillDetailStatus, manualMaterialBillDetail.UpdateTime);
            }
            else
            {
                if (isWork.Value)
                {
                    if (entity.ManualMaterialBillDetailStatus == ManualMaterialBillDetailStatus.Wait)
                        entity.ModifyManualMaterialBillDetailStatus(ManualMaterialBillDetailStatus.Production, DateTime.Now);
                }
                else
                {
                    entity.ModifyManualMaterialBillDetailStatus(ManualMaterialBillDetailStatus.Complete, DateTime.Now);
                }
            }
        }

        public int GetManualMaterialBillDetailNextSerialNumber()
        {
            if (ManualMaterialBillDetails.Any())
            {
                return this.ManualMaterialBillDetails.Max(t => t.SerialNumber) + 1;
            }

            return 1;
        }

        #endregion

        public bool IsSettled()
        {
            return this.ManualMaterialBillStatus == ManualMaterialBillStatus.Settled;
        }

        public void GetMaterialOfValidate(Guid manualMaterialBillDetailId)
        {
            if (this.IsSettled())
            {
                throw new Exception($"生产计划号：{ManualMaterialBillNo}已结单，不能要料，请检查！");
            }

            var manualMaterialBillDetail = this.GetManualMaterialBillDetail(manualMaterialBillDetailId);

            if (manualMaterialBillDetail.IsChangeShift())
            {
                throw new Exception($"生产计划号：{ManualMaterialBillNo}，机组：{manualMaterialBillDetail.MachineName}生产计划是换班状态，请换班！");
            }

            if (manualMaterialBillDetail.IsChangeBrand())
            {
                throw new Exception($"生产计划号：{ManualMaterialBillNo}，机组：{manualMaterialBillDetail.MachineName}生产计划是换牌状态，请返库！");
            }

            if (manualMaterialBillDetail.IsCompleted())
            {
                throw new Exception($"生产计划号：{ManualMaterialBillNo}，机组：{manualMaterialBillDetail.MachineName}生产计划已完成，请检查！");
            }

            var now = DateTime.Now;

            if (now > PlanEndTime)
            {
                throw new Exception($"生产计划号：{ManualMaterialBillNo}，计划结束时间：{PlanEndTime}，当前时间：{now}已结束，不能要料；请换班！");
            }
        }

        public ManualMaterialBillDetail TryGetManualMaterialBillDetail(string machineCode)
        {
            var manualMaterialBillDetail = this.ManualMaterialBillDetails.FirstOrDefault(t => t.MachineCode == machineCode);

            return manualMaterialBillDetail;
        }

        public ManualMaterialBillDetail GetManualMaterialBillDetail(string machineCode)
        {
            var manualMaterialBillDetail = this.ManualMaterialBillDetails
                .Where(t => t.MachineCode == machineCode)
                .OrderBy(t => t.CreateTime)
                .FirstOrDefault();

            if (manualMaterialBillDetail == null)
            {
                throw new Exception($"生产计划号：{ManualMaterialBillNo}，机组：{machineCode}不存在生产计划；请检查！");
            }

            return manualMaterialBillDetail;
        }

        public ManualMaterialBillDetail GetManualMaterialBillDetailOfUncompleted(string machineCode)
        {
            var manualMaterialBillDetail = this.ManualMaterialBillDetails.OrderBy(d => d.CreateTime)
                .Where(d => d.MachineCode == machineCode && d.ManualMaterialBillDetailStatus != ManualMaterialBillDetailStatus.Complete)
                .OrderBy(t => t.CreateTime)
                .FirstOrDefault();

            if (manualMaterialBillDetail == null)
            {
                throw new Exception($"生产计划号：{ManualMaterialBillNo}，机组：{machineCode}不存在未完成生产计划；请检查！");
            }

            return manualMaterialBillDetail;
        }

        public ManualMaterialBillDetail TryGetManualMaterialBillDetailOfWaitOrProduction(string machineCode)
        {
            var manualMaterialBillDetail = this.ManualMaterialBillDetails
                .Where(d => d.MachineCode == machineCode && (d.ManualMaterialBillDetailStatus == ManualMaterialBillDetailStatus.Wait || d.ManualMaterialBillDetailStatus == ManualMaterialBillDetailStatus.Production))
                .OrderBy(t => t.CreateTime)
                .FirstOrDefault();

            return manualMaterialBillDetail;
        }

        public ManualMaterialBillDetail TryGetManualMaterialBillDetailOfWait(string machineCode)
        {
            var manualMaterialBillDetail = this.ManualMaterialBillDetails
                .Where(d => d.MachineCode == machineCode && (d.ManualMaterialBillDetailStatus == ManualMaterialBillDetailStatus.Wait))
                .OrderBy(t => t.CreateTime)
                .FirstOrDefault();

            return manualMaterialBillDetail;
        }

        public ManualMaterialBillDetail GetManualMaterialBillDetail(Guid manualMaterialBillDetailId)
        {
            var manualMaterialBillDetail = this.ManualMaterialBillDetails
                .Where(t => t.Id == manualMaterialBillDetailId)
                .OrderBy(t => t.CreateTime)
                .FirstOrDefault();

            if (manualMaterialBillDetail == null)
            {
                throw new Exception($"生产计划明细Id：{manualMaterialBillDetailId}不存在；请检查！");
            }

            return manualMaterialBillDetail;
        }

        public void SyncBillNo(string moveBillNo)
        {
            this.BillNo = moveBillNo;
        }

        public void TryProduction(Guid manualMaterialBillDetailId)
        {
            var manualMaterialBillDetail = this.GetManualMaterialBillDetail(manualMaterialBillDetailId);
            manualMaterialBillDetail.TryProduction();
        }

        public void Complete(Guid manualMaterialBillDetailId)
        {
            var manualMaterialBillDetail = this.GetManualMaterialBillDetail(manualMaterialBillDetailId);
            manualMaterialBillDetail.Complete();
        }

        public void AddManualMaterialBillDetail(ManualMaterialBillDetail manualMaterialBillDetailDto)
        {
            var manualMaterialBillDetail = this.TryGetManualMaterialBillDetailOfWait(manualMaterialBillDetailDto.MachineCode);

            if (manualMaterialBillDetail != null)
            {
                throw new Exception($"生产计划号：{ManualMaterialBillNo}机组：{manualMaterialBillDetailDto.MachineName}存在等待中的生产计划，不能添加；请检查！");
            }

            var serialNumber = this.GetManualMaterialBillDetailNextSerialNumber();
            manualMaterialBillDetailDto.SetSerialNumber(serialNumber);
            this.ManualMaterialBillDetails.Add(manualMaterialBillDetailDto);
        }

        public void ChangeShift(ManualMaterialBillDetail manualMaterialBillDetailDto)
        {
            var manualMaterialBillDetail = this.TryGetManualMaterialBillDetailOfWaitOrProduction(manualMaterialBillDetailDto.MachineCode);

            if (manualMaterialBillDetail != null)
            {
                manualMaterialBillDetail.ChangeShift();
            }

            this.AddManualMaterialBillDetail(manualMaterialBillDetailDto);
        }

        public void Production(Guid manualMaterialBillDetailId)
        {
            var manualMaterialBillDetail = this.GetManualMaterialBillDetail(manualMaterialBillDetailId);

            manualMaterialBillDetail.Production();
        }

        public void ChangeShift(Guid manualMaterialBillDetailId)
        {
            var manualMaterialBillDetail = this.GetManualMaterialBillDetail(manualMaterialBillDetailId);

            manualMaterialBillDetail.ChangeShift();
        }

        public void ChangeBrand(Guid manualMaterialBillDetailId)
        {
            var manualMaterialBillDetail = this.GetManualMaterialBillDetail(manualMaterialBillDetailId);

            manualMaterialBillDetail.ChangeBrand();
        }

        public void ChangeBrand(ManualMaterialBillDetail manualMaterialBillDetailDto)
        {
            var manualMaterialBillDetail = this.TryGetManualMaterialBillDetailOfWaitOrProduction(manualMaterialBillDetailDto.MachineCode);

            if (manualMaterialBillDetail != null)
            {
                manualMaterialBillDetail.ChangeBrand();
            }

            this.AddManualMaterialBillDetail(manualMaterialBillDetailDto);
        }

        public void RemoveManualMaterialBillDetailBy(string originWorkNo)
        {
            var entities = this.ManualMaterialBillDetails.Where(f => originWorkNo.Contains(originWorkNo)).ToArray();

            for (int i = 0; i < entities.Count(); i++)
            {
                this.ManualMaterialBillDetails.Remove(entities[i]);
            }
        }
    }
}
