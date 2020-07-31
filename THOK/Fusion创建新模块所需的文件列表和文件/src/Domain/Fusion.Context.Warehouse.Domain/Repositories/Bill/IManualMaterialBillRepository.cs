using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Context.Warehouse.Domain.Repositories.Bill
{
    public interface IManualMaterialBillRepository
    {
        void Add(ManualMaterialBill manualMaterialBill);
        void AddRange(IList<ManualMaterialBill> manualMaterialBills);
        void Remove(string[] manualMaterialBillNos);
        ManualMaterialBill GetBy(string manualMaterialBillNo);
        ManualMaterialBill TryGetBy(string manualMaterialBillNo);
        ManualMaterialBill GetBy(string teamCode, string machineCode);
        ManualMaterialBill TryGetManualMaterialBillOfExecuting(string machineCode);
        ManualMaterialBill GetManualMaterialBillOfExecuting(string machineCode);
        ManualMaterialBill TryGetManualMaterialBill(string originPlanNo);
        ManualMaterialBill GetManualMaterialBill(string originWorkNo);
    }
}
