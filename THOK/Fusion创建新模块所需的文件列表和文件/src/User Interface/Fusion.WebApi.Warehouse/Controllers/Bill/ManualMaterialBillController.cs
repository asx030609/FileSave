using System;
using System.Collections.Generic;
using System.Composition;
using System.Linq;
using System.Web;
using System.Web.Http;
using Fusion.Context.Warehouse.Application.Models.Bill.ManualMaterialBills;
using Fusion.Context.Warehouse.Application.Services.Interfaces.Bill;
using FusionFramework.Core.Authentication;
using FusionFramework.ManagedExtensibilityFramework.Web;
using FusionFramework.NPOI.Excel;
using Newtonsoft.Json;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.WebApi.Warehouse.Controllers.Bill
{
    public class ManualMaterialBillController : ApiController
    {
        [Import]
        public IAuthenticationService AuthenticationService { get; set; }
        public IManualMaterialBillService ManualMaterialBillService { get; set; }

        #region ManualMaterialBill主表
        [HttpGet]
        public StandardDataModel<ManualMaterialBillModel[]> Find(int page, int start, int limit, string sort = "", string filter = "")
        {
            int total;
            var list = ManualMaterialBillService.Find(page, start, limit, sort, filter, out total);
            return new StandardDataModel<ManualMaterialBillModel[]> { success = true, data = list.ToArray(), total = total };
        }

        [HttpPost]
        public StandardDataModel Add(ManualMaterialBillModel manualMaterialBillModel)
        {
            manualMaterialBillModel.Maker = AuthenticationService.CurrentUserName;
            ManualMaterialBillService.Add(manualMaterialBillModel);
            return new StandardDataModel { success = true, msg = "添加成功！" };
        }

        [HttpPut]
        [Route("Api/ManualMaterialBill/Modify/{manualMaterialBillNo}")]
        public StandardDataModel Modify(string manualMaterialBillNo, ManualMaterialBillModel manualMaterialBillModel)
        {
            manualMaterialBillModel.Maker = AuthenticationService.CurrentUserName;
            ManualMaterialBillService.Modify(manualMaterialBillNo, manualMaterialBillModel);
            return new StandardDataModel { success = true, msg = "修改成功！" };
        }

        [HttpPost]
        public StandardDataModel DetailAdd(ManualMaterialBill manualMaterialBill)
        {
            manualMaterialBill.Auditor = AuthenticationService.CurrentUserName;
            ManualMaterialBillService.DetailAdd(manualMaterialBill.Auditor, manualMaterialBill.ManualMaterialBillNo, manualMaterialBill.PlanBeginTime, manualMaterialBill.PlanEndTime);
            return new StandardDataModel { success = true, msg = "添加成功！" };
        }

        [HttpDelete]
        public StandardDataModel Remove(string[] manualMaterialBillNos)
        {
            ManualMaterialBillService.Remove(manualMaterialBillNos);
            return new StandardDataModel { success = true, msg = "删除成功！" };
        }

        [HttpGet]
        public void ExportManualMaterialBillExcel(string title, string columns, string sort = "", string filter = "")
        {
            var list = ManualMaterialBillService.GetManualMaterialBillExportData(sort, filter);
            var excelModel = new ExcelModel<ManualMaterialBillModel>() { Title = title, Columns = JsonConvert.DeserializeObject<IList<Column>>(columns), Data = list };
            ExcelFactory.CreateExcel(excelModel);
        }
        #endregion

        #region ManualMaterialBillDetail细表
        [HttpGet]
        [AllowAnonymous]
        public StandardDataModel<ManualMaterialBillDetailModel[]> FindManualMaterialBillDetail(string manualMaterialBillNo, int page, int start, int limit, string sort = "", string filter = "")
        {
            int total;
            var list = ManualMaterialBillService.FindManualMaterialBillDetail(manualMaterialBillNo, page, start, limit, sort, filter, out total);
            return new StandardDataModel<ManualMaterialBillDetailModel[]> { success = true, data = list.ToArray(), total = total };
        }

        [HttpPost]
        public StandardDataModel AddManualMaterialBillDetail(string manualMaterialBillNo, ManualMaterialBillDetailModel manualMaterialBillDetailModel)
        {
            var maker = AuthenticationService.CurrentUserName;
            var machineCodes = manualMaterialBillDetailModel.MachineCode.Split(',');
            var machineNames = manualMaterialBillDetailModel.MachineName.Split(',');

            for (int i = 0; i < machineCodes.Length; i++)
            {
                manualMaterialBillDetailModel.Id = Guid.NewGuid();
                manualMaterialBillDetailModel.MachineCode = machineCodes[i];
                manualMaterialBillDetailModel.MachineName = machineNames[i];
                ManualMaterialBillService.AddManualMaterialBillDetail(manualMaterialBillNo, maker, manualMaterialBillDetailModel);
            }
            return new StandardDataModel { success = true, msg = "添加成功！" };
        }

        [HttpPut]
        public StandardDataModel ModifyManualMaterialBillDetail(string manualMaterialBillNo, ManualMaterialBillDetailModel manualMaterialBillDetailModel)
        {
            var maker = AuthenticationService.CurrentUserName;
            ManualMaterialBillService.ModifyManualMaterialBillDetail(manualMaterialBillNo, maker, manualMaterialBillDetailModel);
            return new StandardDataModel { success = true, msg = "修改成功！" };
        }

        [HttpDelete]
        public StandardDataModel RemoveManualMaterialBillDetail(string manualMaterialBillNo, Guid[] manualMaterialBillDetailIds)
        {
            var maker = AuthenticationService.CurrentUserName;
            ManualMaterialBillService.RemoveManualMaterialBillDetail(manualMaterialBillNo, maker, manualMaterialBillDetailIds);
            return new StandardDataModel { success = true, msg = "删除成功！" };
        }

        [HttpGet]
        public void ExportManualMaterialBillDetailExcel(string manualMaterialBillNo, string title, string columns, string sort = "", string filter = "")
        {
            var list = ManualMaterialBillService.GetManualMaterialBillDetailExportData(manualMaterialBillNo, sort, filter);
            var excelModel = new ExcelModel<ManualMaterialBillDetailModel>() { Title = title, Columns = JsonConvert.DeserializeObject<IList<Column>>(columns), Data = list };
            ExcelFactory.CreateExcel(excelModel);
        }
        #endregion

        #region 主表状态
        [HttpGet]
        public StandardDataModel Verify(string manualMaterialBillNo)
        {
            var auditor = AuthenticationService.CurrentUserName;
            ManualMaterialBillService.Verify(manualMaterialBillNo, auditor);
            return new StandardDataModel { success = true };
        }
        [HttpPost]
        public StandardDataModel BatchVerify(string[] manualMaterialBillNos)
        {
            var auditor = AuthenticationService.CurrentUserName;
            foreach(string manualMaterialBillNo in manualMaterialBillNos)
            {
                ManualMaterialBillService.Verify(manualMaterialBillNo, auditor);
            }
            return new StandardDataModel { success = true };
        }

        [HttpGet]
        public StandardDataModel Reverify(string manualMaterialBillNo)
        {
            ManualMaterialBillService.Reverify(manualMaterialBillNo);
            return new StandardDataModel { success = true };
        }
        #endregion

        #region 细表状态
        [HttpGet]
        public StandardDataModel Production(string manualMaterialBillNo, Guid manualMaterialBillDetailId)
        {
            ManualMaterialBillService.Production(manualMaterialBillNo, manualMaterialBillDetailId);
            return new StandardDataModel { success = true };
        }
        
        #endregion
        

        private string GetClientIP()
        {
            var hostAddress = HttpContext.Current.Request.UserHostAddress;

            return hostAddress;
        }

        public class ManualMaterialBill
        {
            public string ManualMaterialBillNo { get; set; }
            public DateTime PlanBeginTime { get; set; }
            public DateTime PlanEndTime { get; set; }
            public string Auditor { get; set; }
        }
    }
}
