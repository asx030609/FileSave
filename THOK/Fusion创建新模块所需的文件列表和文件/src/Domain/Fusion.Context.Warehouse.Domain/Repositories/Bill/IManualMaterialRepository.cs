using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills;

/*
* 2018-06-07 Create by hongwanzhen
*/
namespace Fusion.Context.Warehouse.Domain.Repositories.Bill
{
    public interface IManualMaterialRepository
    {
        void Add(ManualMaterialBill manualMaterialBill);
        void AddRange(IList<ManualMaterialBill> manualMaterialsBills);
        void Remove(string[] manualMaterialsBillNos);
        ManualMaterialBill GetBy(string manualMaterialsBillNo);
        ManualMaterialBill TryGetBy(string manualMaterialsBillNo);
        ManualMaterialBill GetBy(string teamCode, string machineCode);
        ManualMaterialBill TryGetManualMaterialBillOfExecuting(string machineCode);
        ManualMaterialBill GetManualMaterialBillOfExecuting(string machineCode);
        ManualMaterialBill TryGetManualMaterialBill(string originPlanNo);
        ManualMaterialBill GetManualMaterialBill(string originWorkNo);
    }
}
