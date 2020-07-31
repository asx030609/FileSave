using System;
using System.Collections.Generic;
using System.Composition;
using System.Linq;
using Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills;
using Fusion.Context.Warehouse.Domain.Repositories.Bill;
using FusionFramework;
using FusionFramework.EntityFramework;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Infrastructure.Repository.Warehouse.Repositories.Bill
{
    public class ManualMaterialBillRepository : IManualMaterialBillRepository
    {
        [Import("default", AllowDefault = true)]
        public IDbContext DbContext { get; set; }

        public void Add(ManualMaterialBill manualMaterialBill)
        {
            DbContext.Set<ManualMaterialBill>().Add(manualMaterialBill);
        }

        public void AddRange(IList<ManualMaterialBill> manualMaterialBills)
        {
            DbContext.Set<ManualMaterialBill>().AddRange(manualMaterialBills);
        }

        public void Remove(string[] manualMaterialBillNos)
        {
            var manualMaterialBills = DbContext.Set<ManualMaterialBill>()
                .Where(t => manualMaterialBillNos.Contains(t.ManualMaterialBillNo));

            DbContext.Set<ManualMaterialBill>().RemoveRange(manualMaterialBills);
        }

        public ManualMaterialBill GetBy(string manualMaterialBillNo)
        {
            var manualMaterialBill = DbContext.Set<ManualMaterialBill>()
                .FirstOrDefault(t => t.ManualMaterialBillNo == manualMaterialBillNo);
            if (manualMaterialBill == null)
            {
                throw new FusionException($"生产计划单号：{manualMaterialBillNo}，不存在；请刷新！");
            }

            return manualMaterialBill;
        }

        public ManualMaterialBill TryGetBy(string manualMaterialBillNo)
        {
            return DbContext.Set<ManualMaterialBill>()
                .FirstOrDefault(t => t.ManualMaterialBillNo == manualMaterialBillNo);
        }

        public ManualMaterialBill GetBy(string teamCode, string machineCode)
        {
            var manualMaterialBill = DbContext.Set<ManualMaterialBill>()
                 .Where(t => t.ManualMaterialBillStatus != ManualMaterialBillStatus.Settled
                 && t.ManualMaterialBillDetails.Any(it => it.MachineCode == machineCode
                                                                            && it.TeamCode == teamCode
                                                                            && it.ManualMaterialBillDetailStatus != ManualMaterialBillDetailStatus.Complete))
                 .OrderBy(it => it.CreateTime)
                 .FirstOrDefault();

            if (manualMaterialBill == null)
            {
                throw new Exception($"未获班组的生产计划，请联系相关人员!");
            }

            if (manualMaterialBill.ManualMaterialBillStatus != ManualMaterialBillStatus.Executing)
            {
                var manualMaterialBillDetail = manualMaterialBill.ManualMaterialBillDetails.First(e => e.TeamCode == teamCode);
                throw new Exception($"【{manualMaterialBillDetail.TeamName}】的生产计划{manualMaterialBill.ManualMaterialBillNo}未作业，请联系管理员!");
            }
            return manualMaterialBill;
        }

        public ManualMaterialBill TryGetManualMaterialBillOfExecuting(string machineCode)
        {
            var manualMaterialBill = DbContext.Set<ManualMaterialBill>()
                 .Where(t => t.ManualMaterialBillStatus == ManualMaterialBillStatus.Executing
                     && t.ManualMaterialBillDetails.Any(it => it.MachineCode == machineCode
                                                    && it.ManualMaterialBillDetailStatus != ManualMaterialBillDetailStatus.Complete))
                 .OrderBy(it => it.CreateTime)
                 .FirstOrDefault();

            return manualMaterialBill;
        }

        public ManualMaterialBill GetManualMaterialBillOfExecuting(string machineCode)
        {
            var manualMaterialBill = DbContext.Set<ManualMaterialBill>()
                 .Where(t => t.ManualMaterialBillStatus == ManualMaterialBillStatus.Executing
                     && t.ManualMaterialBillDetails.Any(it => it.MachineCode == machineCode
                                                    && it.ManualMaterialBillDetailStatus != ManualMaterialBillDetailStatus.Complete))
                 .OrderBy(it => it.CreateTime)
                 .FirstOrDefault();

            if (manualMaterialBill == null)
            {
                throw new Exception($"机组: {machineCode} 不存在执行中的生产计划；请检查！");
            }

            return manualMaterialBill;
        }

        public ManualMaterialBill TryGetManualMaterialBill(string originPlanNo)
        {
            return DbContext.Set<ManualMaterialBill>()
                .FirstOrDefault(t => t.OriginPlanNo == originPlanNo);
        }

        public ManualMaterialBill GetManualMaterialBill(string originWorkNo)
        {
            var manualMaterialBill = DbContext.Set<ManualMaterialBill>()
                .Where(p => p.ManualMaterialBillDetails.Any(d => d.OriginWorkNo == originWorkNo))
                .FirstOrDefault();

            if (manualMaterialBill == null)
            {
                throw new Exception($"源工单号：{originWorkNo}对应生产计划不存在；请检查！");
            }

            return manualMaterialBill;
        }
    }
}
