using System;
using System.Collections.Generic;
using Fusion.Context.Warehouse.Application.Models.Bill;
using Fusion.Context.Warehouse.Application.Models.Bill.ManualMaterialBills;
using Fusion.Context.Warehouse.Application.Models.MachineManagement.MachineCalls;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Context.Warehouse.Application.Services.Interfaces.Bill
{
    public interface IManualMaterialBillService
    {
        IList<ManualMaterialBillModel> Find(int page, int start, int limit, string sort, string filter, out int total);
        void Add(ManualMaterialBillModel manualMaterialBillModel);
        void Modify(string manualMaterialBillNo, ManualMaterialBillModel manualMaterialBillModel);
        void Remove(string[] manualMaterialBillNos);
        IList<ManualMaterialBillModel> GetReportData(string sort, int page = 1, int limit = int.MaxValue, string filter = "");
        IList<ManualMaterialBillModel> GetManualMaterialBillExportData(string sort, string filter = "");
        IList<ManualMaterialBillDetailModel> FindManualMaterialBillDetail(string manualMaterialBillNo, int page, int start, int limit, string sort, string filter, out int total);
        void AddManualMaterialBillDetail(string manualMaterialBillNo, string maker, ManualMaterialBillDetailModel manualMaterialBillDetailModel);
        void ModifyManualMaterialBillDetail(string manualMaterialBillNo, string maker, ManualMaterialBillDetailModel manualMaterialBillDetailModel);
        void RemoveManualMaterialBillDetail(string manualMaterialBillNo, string maker, Guid[] manualMaterialBillDetailIds);
        IList<ManualMaterialBillModel> GetManualMaterialBillDetailReportData(string manualMaterialBillNo, string sort, int page = 1, int limit = int.MaxValue, string filter = "");
        IList<ManualMaterialBillDetailModel> GetManualMaterialBillDetailExportData(string manualMaterialBillNo, string sort, string filter = "");
        void Verify(string manualMaterialBillNo, string auditor);
        void Reverify(string manualMaterialBillNo);
        void TryVerify(string manualMaterialBillNo, string auditor);
        void Production(string manualMaterialBillNo, Guid manualMaterialBillDetailId);
        void DetailAdd(string maker, string manualMaterialBillNo, DateTime planBeginTime, DateTime planEndTime);
    }
}
