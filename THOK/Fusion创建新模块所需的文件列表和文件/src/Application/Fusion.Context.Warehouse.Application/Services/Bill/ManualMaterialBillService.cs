using System;
using System.Collections.Generic;
using System.Composition;
using System.Linq;
using AutoMapper;
using Fusion.Context.Warehouse.Application.Models.Bill;
using Fusion.Context.Warehouse.Application.Models.Bill.ManualMaterialBills;
using Fusion.Context.Warehouse.Application.Models.Warehouse.Locations;
using Fusion.Context.Warehouse.Application.Services.Interfaces.Bill;
using Fusion.Context.Warehouse.Domain.Factories;
using Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills;
using Fusion.Context.Warehouse.Domain.Models.MachineManagement.MachineCalls;
using Fusion.Context.Warehouse.Domain.Models.MachineManagement.MachineHandovers;
using Fusion.Context.Warehouse.Domain.Models.Values;
using Fusion.Context.Warehouse.Domain.RemoteServices;
using Fusion.Context.Warehouse.Domain.Repositories.Bill;
using Fusion.Context.Warehouse.Domain.Repositories.MachineManagement;
using Fusion.Context.Warehouse.Domain.Repositories.Warehouse;
using Fusion.Context.Warehouse.Domain.Services.Interfaces;
using FusionFramework.EntityFramework;
using FusionFramework.Extensions.Linq;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Context.Warehouse.Application.Services.Bill
{
    public class ManualMaterialBillService : IManualMaterialBillService
    {
        [Import]
        public IDbQuery DbQuery { get; set; }

        public IManualMaterialBillRepository ManualMaterialBillRepository { get; set; }
        public IMachineRepository MachineRepository { get; set; }

        public IGenerateSequenceService GenerateSequenceService { get; set; }
        public IDictionaryService DictioanryService { get; set; }
        public ITeamService TeamService { get; set; }
        public IMachineCallRepository MachineCallRepository { get; set; }
        public IWarehouseRepository WarehouseRepository { get; set; }
        public ILocationRepository LocationRepository { get; set; }
        public IParameterService ParameterService { get; set; }
        public IOutAllotService OutAllotService { get; set; }
        public IEmployeeService EmployeeService { get; set; }
        public IProductService ProductService { get; set; }
        public IOutBillRepository OutBillRepository { get; set; }
        [Import(AllowDefault = true)]
        public ILyycFLKToMesRemoteService lyycFLKToMesRemoteService { get; set; }

        #region ManualMaterialBill
        public IList<ManualMaterialBillModel> Find(int page, int start, int limit, string sort, string filter, out int total)
        {
            var manualMaterialBills = DbQuery.Query<ManualMaterialBill>();

            var result = from m in manualMaterialBills
                         select new ManualMaterialBillModel
                         {
                             ManualMaterialBillNo = m.ManualMaterialBillNo,
                             PlanBeginTime = m.PlanBeginTime,
                             PlanEndTime = m.PlanEndTime,
                             ManualMaterialBillStatus = m.ManualMaterialBillStatus,
                             OriginPlanNo = m.OriginPlanNo,
                             Maker = m.Maker,
                             MakeTime = m.MakeTime,
                             Auditor = m.Auditor,
                             AuditTime = m.AuditTime,
                             BillNo = m.BillNo,
                             CreateTime = m.CreateTime,
                             UpdateTime = m.UpdateTime,
                             RowVersion = m.RowVersion,
                         };

            if (!string.IsNullOrEmpty(filter))
            {
                result = result.Where(filter);
            }
            else
            {
                result = result.Where(t => t.ManualMaterialBillStatus != ManualMaterialBillStatus.Settled);
            }

            if (!string.IsNullOrEmpty(sort))
            {
                result = result.OrderBy(sort);
            }
            else
            {
                result = result.OrderBy(t => t.ManualMaterialBillNo);
            }

            total = result.Count();
            result = result.Skip((page - 1) * limit).Take(limit);
            return result.ToList();
        }

        public void Add(ManualMaterialBillModel manualMaterialBillModel)
        {
            if (string.IsNullOrEmpty(manualMaterialBillModel.ManualMaterialBillNo) || manualMaterialBillModel.ManualMaterialBillNo.Length > 32)
            {
                manualMaterialBillModel.ManualMaterialBillNo = GenerateSequenceService.GenerateIdentity("manualMaterialBillNo");
            }

            var displayChinese = ParameterService.GetParameterValueBy<bool>("DisplayChinese", false);

            if (displayChinese)
            {
                manualMaterialBillModel.Maker = EmployeeService.GetEmployee(manualMaterialBillModel.Maker).EmployeeName;
            }

            var manualMaterialBill = Mapper.Map<ManualMaterialBill>(manualMaterialBillModel);
            ManualMaterialBillRepository.Add(manualMaterialBill);
        }

        public void Modify(string manualMaterialBillNo, ManualMaterialBillModel manualMaterialBillModel)
        {
            var entity = ManualMaterialBillRepository.GetBy(manualMaterialBillNo);

            var displayChinese = ParameterService.GetParameterValueBy<bool>("DisplayChinese", false);

            if (displayChinese)
            {
                manualMaterialBillModel.Maker = EmployeeService.GetEmployee(manualMaterialBillModel.Maker).EmployeeName;
            }

            var manualMaterialBill = Mapper.Map<ManualMaterialBill>(manualMaterialBillModel);
            entity.Modify(manualMaterialBill);
        }

        public void Remove(string[] manualMaterialBillNos)
        {
            ManualMaterialBillRepository.Remove(manualMaterialBillNos);
        }

        public IList<ManualMaterialBillModel> GetReportData(string sort, int page = 1, int limit = int.MaxValue, string filter = "")
        {
            var manualMaterialBillQuery = DbQuery.Query<ManualMaterialBill>();
            var manualMaterialBillStatusList = DictioanryService.GetDictionariesBy("ManualMaterialBillStatus");

            var manualMaterialBills = from m in manualMaterialBillQuery
                                      where m.ManualMaterialBillStatus != ManualMaterialBillStatus.Settled
                                      select new ManualMaterialBillModel
                                      {
                                          ManualMaterialBillNo = m.ManualMaterialBillNo,
                                          PlanBeginTime = m.PlanBeginTime,
                                          PlanEndTime = m.PlanEndTime,
                                          ManualMaterialBillStatus = m.ManualMaterialBillStatus,
                                          Maker = m.Maker,
                                          MakeTime = m.MakeTime,
                                          Auditor = m.Auditor,
                                          AuditTime = m.AuditTime,
                                          CreateTime = m.CreateTime,
                                          UpdateTime = m.UpdateTime,
                                          RowVersion = m.RowVersion,
                                      };

            if (!string.IsNullOrEmpty(filter))
            {
                manualMaterialBills = manualMaterialBills.Where(filter);
            }
            if (!string.IsNullOrEmpty(sort))
            {
                manualMaterialBills = manualMaterialBills.OrderBy(sort);
            }
            else
            {
                manualMaterialBills = manualMaterialBills.OrderBy(t => t.ManualMaterialBillNo);
            }

            manualMaterialBills = manualMaterialBills.Skip((page - 1) * limit).Take(limit);

            var result = from m in manualMaterialBills.ToList()
                         join s in manualMaterialBillStatusList on (int)m.ManualMaterialBillStatus equals s.Value
                         select new ManualMaterialBillModel
                         {
                             ManualMaterialBillNo = m.ManualMaterialBillNo,
                             PlanBeginTime = m.PlanBeginTime,
                             PlanEndTime = m.PlanEndTime,
                             ManualMaterialBillStatus = m.ManualMaterialBillStatus,
                             ManualMaterialBillStatusName = s.Name,
                             Maker = m.Maker,
                             MakeTime = m.MakeTime,
                             Auditor = m.Auditor,
                             AuditTime = m.AuditTime,
                             StartTime = m.StartTime,
                             FinishTime = m.FinishTime,
                             CreateTime = m.CreateTime,
                             UpdateTime = m.UpdateTime,
                             RowVersion = m.RowVersion,
                         };

            return result.ToList();
        }

        public IList<ManualMaterialBillModel> GetManualMaterialBillExportData(string sort, string filter = "")
        {
            var manualMaterialBillQuery = DbQuery.Query<ManualMaterialBill>();
            var manualMaterialBillStatusList = DictioanryService.GetDictionariesBy("ManualMaterialBillStatus");

            var manualMaterialBills = from m in manualMaterialBillQuery
                                      where m.ManualMaterialBillStatus != ManualMaterialBillStatus.Settled
                                      select new ManualMaterialBillModel
                                      {
                                          ManualMaterialBillNo = m.ManualMaterialBillNo,
                                          PlanBeginTime = m.PlanBeginTime,
                                          PlanEndTime = m.PlanEndTime,
                                          ManualMaterialBillStatus = m.ManualMaterialBillStatus,
                                          Maker = m.Maker,
                                          MakeTime = m.MakeTime,
                                          Auditor = m.Auditor,
                                          AuditTime = m.AuditTime,
                                          CreateTime = m.CreateTime,
                                          UpdateTime = m.UpdateTime,
                                          RowVersion = m.RowVersion,
                                      };

            if (!string.IsNullOrEmpty(filter))
            {
                manualMaterialBills = manualMaterialBills.Where(filter);
            }
            if (!string.IsNullOrEmpty(sort))
            {
                manualMaterialBills = manualMaterialBills.OrderBy(sort);
            }
            else
            {
                manualMaterialBills = manualMaterialBills.OrderBy(t => t.ManualMaterialBillNo);
            }

            var result = from m in manualMaterialBills.ToList()
                         join s in manualMaterialBillStatusList on (int)m.ManualMaterialBillStatus equals s.Value
                         select new ManualMaterialBillModel
                         {
                             ManualMaterialBillNo = m.ManualMaterialBillNo,
                             PlanBeginTime = m.PlanBeginTime,
                             PlanEndTime = m.PlanEndTime,
                             ManualMaterialBillStatus = m.ManualMaterialBillStatus,
                             ManualMaterialBillStatusName = s.Name,
                             Maker = m.Maker,
                             MakeTime = m.MakeTime,
                             Auditor = m.Auditor,
                             AuditTime = m.AuditTime,
                             StartTime = m.StartTime,
                             FinishTime = m.FinishTime,
                             CreateTime = m.CreateTime,
                             UpdateTime = m.UpdateTime,
                             RowVersion = m.RowVersion,
                         };

            return result.ToList();
        }
        #endregion

        #region ManualMaterialBillDetail
        public IList<ManualMaterialBillDetailModel> FindManualMaterialBillDetail(string manualMaterialBillNo, int page, int start, int limit, string sort, string filter, out int total)
        {
            var manualMaterialBillDetails = DbQuery.Query<ManualMaterialBillDetail>();

            var result = from d in manualMaterialBillDetails
                         where d.ManualMaterialBillNo == manualMaterialBillNo
                         select new ManualMaterialBillDetailModel
                         {
                             Id = d.Id,
                             SerialNumber = d.SerialNumber,
                             ManualMaterialBillNo = d.ManualMaterialBillNo,
                             TeamCode = d.TeamCode,
                             TeamName = d.TeamName,
                             MachineCode = d.MachineCode,
                             MachineName = d.MachineName,
                             BrandCode = d.BrandCode,
                             BrandName = d.BrandName,
                             OriginWorkNo = d.OriginWorkNo,
                             ManualMaterialBillDetailStatus = d.ManualMaterialBillDetailStatus,
                             ProductionBeginTime = d.ProductionBeginTime,
                             ProductionEndTime = d.ProductionEndTime,
                             CreateTime = d.CreateTime,
                             UpdateTime = d.UpdateTime,
                             RowVersion = d.RowVersion
                         };

            if (!string.IsNullOrEmpty(filter))
            {
                result = result.Where(filter);
            }
            if (!string.IsNullOrEmpty(sort))
            {
                result = result.OrderBy(sort);
            }
            else
            {
                result = result.OrderBy(t => t.MachineCode);
            }

            total = result.Count();
            result = result.Skip((page - 1) * limit).Take(limit);
            return result.ToList();
        }

        public void AddManualMaterialBillDetail(string manualMaterialBillNo, string maker, ManualMaterialBillDetailModel manualMaterialBillDetailModel)
        {
            var manualMaterialBill = ManualMaterialBillRepository.GetBy(manualMaterialBillNo);
            var manualMaterialBillDetail = Mapper.Map<ManualMaterialBillDetail>(manualMaterialBillDetailModel);

            manualMaterialBill.AddManualMaterialBillDetail(manualMaterialBillDetail);
        }

        public void ModifyManualMaterialBillDetail(string manualMaterialBillNo, string maker, ManualMaterialBillDetailModel manualMaterialBillDetailModel)
        {
            var manualMaterialBill = ManualMaterialBillRepository.GetBy(manualMaterialBillNo);
            var manualMaterialBillDetail = Mapper.Map<ManualMaterialBillDetail>(manualMaterialBillDetailModel);

            manualMaterialBill.ModifyManualMaterialBillDetail(maker, manualMaterialBillDetail);
        }

        public void RemoveManualMaterialBillDetail(string manualMaterialBillNo, string maker, Guid[] manualMaterialBillDetailIds)
        {
            var manualMaterialBill = ManualMaterialBillRepository.GetBy(manualMaterialBillNo);
            manualMaterialBill.RemoveManualMaterialBillDetail(maker, manualMaterialBillDetailIds);
        }

        public IList<ManualMaterialBillModel> GetManualMaterialBillDetailReportData(string manualMaterialBillNo, string sort, int page = 1, int limit = int.MaxValue, string filter = "")
        {
            var manualMaterialBillQuery = DbQuery.Query<ManualMaterialBill>().Where(a => a.ManualMaterialBillNo == manualMaterialBillNo).ToList();
            var manualMaterialBillDetailQuery = DbQuery.Query<ManualMaterialBillDetail>();
            var manualMaterialBillStatusList = DictioanryService.GetDictionariesBy("ManualMaterialBillStatus");
            var manualMaterialBillDetailStatusList = DictioanryService.GetDictionariesBy("ManualMaterialBillDetailStatus");

            var manualMaterialBillDetailResult = from d in manualMaterialBillDetailQuery
                                                 where d.ManualMaterialBillNo == manualMaterialBillNo
                                                 select new ManualMaterialBillDetailModel
                                                 {
                                                     Id = d.Id,
                                                     SerialNumber = d.SerialNumber,
                                                     ManualMaterialBillNo = d.ManualMaterialBillNo,
                                                     TeamCode = d.TeamCode,
                                                     TeamName = d.TeamName,
                                                     MachineCode = d.MachineCode,
                                                     MachineName = d.MachineName,
                                                     BrandCode = d.BrandCode,
                                                     BrandName = d.BrandName,
                                                     OriginWorkNo = d.OriginWorkNo,
                                                     ManualMaterialBillDetailStatus = d.ManualMaterialBillDetailStatus,
                                                     CreateTime = d.CreateTime,
                                                     UpdateTime = d.UpdateTime,
                                                     RowVersion = d.RowVersion
                                                 };

            if (!string.IsNullOrEmpty(filter))
            {
                manualMaterialBillDetailResult = manualMaterialBillDetailResult.Where(filter);
            }
            if (!string.IsNullOrEmpty(sort))
            {
                manualMaterialBillDetailResult = manualMaterialBillDetailResult.OrderBy(sort);
            }
            else
            {
                manualMaterialBillDetailResult = manualMaterialBillDetailResult.OrderBy(t => t.ManualMaterialBillNo);
            }

            manualMaterialBillDetailResult = manualMaterialBillDetailResult.Skip((page - 1) * limit).Take(limit);

            var result = from m in manualMaterialBillQuery
                         join s in manualMaterialBillStatusList on (int)m.ManualMaterialBillStatus equals s.Value
                         select new ManualMaterialBillModel
                         {
                             ManualMaterialBillNo = m.ManualMaterialBillNo,
                             PlanBeginTime = m.PlanBeginTime,
                             PlanEndTime = m.PlanEndTime,
                             ManualMaterialBillStatus = m.ManualMaterialBillStatus,
                             ManualMaterialBillStatusName = s.Name,
                             ManualMaterialBillDetails = (from d in manualMaterialBillDetailResult.ToList()
                                                          join ds in manualMaterialBillDetailStatusList on (int)d.ManualMaterialBillDetailStatus equals ds.Value
                                                          select new ManualMaterialBillDetailModel
                                                          {
                                                              Id = d.Id,
                                                              SerialNumber = d.SerialNumber,
                                                              ManualMaterialBillNo = d.ManualMaterialBillNo,
                                                              TeamCode = d.TeamCode,
                                                              TeamName = d.TeamName,
                                                              MachineCode = d.MachineCode,
                                                              MachineName = d.MachineName,
                                                              BrandCode = d.BrandCode,
                                                              BrandName = d.BrandName,
                                                              OriginWorkNo = d.OriginWorkNo,
                                                              ManualMaterialBillDetailStatus = d.ManualMaterialBillDetailStatus,
                                                              ManualMaterialBillDetailStatusName = ds.Name,
                                                              CreateTime = d.CreateTime,
                                                              UpdateTime = d.UpdateTime,
                                                              RowVersion = d.RowVersion
                                                          }).ToList()
                         };
            return result.ToList();
        }

        public IList<ManualMaterialBillDetailModel> GetManualMaterialBillDetailExportData(string manualMaterialBillNo, string sort, string filter = "")
        {
            var manualMaterialBillDetails = DbQuery.Query<ManualMaterialBillDetail>();
            var manualMaterialBillDetailStatusList = DictioanryService.GetDictionariesBy("ManualMaterialBillDetailStatus");

            var details = from d in manualMaterialBillDetails
                          where d.ManualMaterialBillNo == manualMaterialBillNo
                          select new ManualMaterialBillDetailModel
                          {
                              Id = d.Id,
                              SerialNumber = d.SerialNumber,
                              ManualMaterialBillNo = d.ManualMaterialBillNo,
                              TeamCode = d.TeamCode,
                              TeamName = d.TeamName,
                              MachineCode = d.MachineCode,
                              MachineName = d.MachineName,
                              BrandCode = d.BrandCode,
                              BrandName = d.BrandName,
                              OriginWorkNo = d.OriginWorkNo,
                              ManualMaterialBillDetailStatus = d.ManualMaterialBillDetailStatus,
                              CreateTime = d.CreateTime,
                              UpdateTime = d.UpdateTime,
                              RowVersion = d.RowVersion
                          };

            if (!string.IsNullOrEmpty(filter))
            {
                details = details.Where(filter);
            }
            if (!string.IsNullOrEmpty(sort))
            {
                details = details.OrderBy(sort);
            }
            else
            {
                details = details.OrderBy(t => t.MachineCode);
            }

            var result = from d in details.ToList()
                         join s in manualMaterialBillDetailStatusList on (int)d.ManualMaterialBillDetailStatus equals s.Value
                         select new ManualMaterialBillDetailModel
                         {
                             Id = d.Id,
                             SerialNumber = d.SerialNumber,
                             ManualMaterialBillNo = d.ManualMaterialBillNo,
                             TeamCode = d.TeamCode,
                             TeamName = d.TeamName,
                             MachineCode = d.MachineCode,
                             MachineName = d.MachineName,
                             BrandCode = d.BrandCode,
                             BrandName = d.BrandName,
                             OriginWorkNo = d.OriginWorkNo,
                             ManualMaterialBillDetailStatus = d.ManualMaterialBillDetailStatus,
                             ManualMaterialBillDetailStatusName = s.Name,
                             CreateTime = d.CreateTime,
                             UpdateTime = d.UpdateTime,
                             RowVersion = d.RowVersion
                         };

            return result.ToList();
        }
        #endregion

        #region 主表状态变化
        public void Verify(string manualMaterialBillNo, string auditor)
        {
            var displayChinese = ParameterService.GetParameterValueBy<bool>("DisplayChinese", false);

            if (displayChinese)
            {
                auditor = EmployeeService.GetEmployee(auditor).EmployeeName;
            }

            var manualMaterialBill = ManualMaterialBillRepository.GetBy(manualMaterialBillNo);
            manualMaterialBill.Verify(auditor);
        }

        public void TryVerify(string manualMaterialBillNo, string auditor)
        {
            var manualMaterialBill = ManualMaterialBillRepository.GetBy(manualMaterialBillNo);
            manualMaterialBill.TryVerify(auditor);
        }

        public void Reverify(string manualMaterialBillNo)
        {
            var manualMaterialBill = ManualMaterialBillRepository.GetBy(manualMaterialBillNo);
            manualMaterialBill.Reverify();
        }
        #endregion

        #region 细表状态变化 
        public void Production(string manualMaterialBillNo, Guid manualMaterialBillDetailId)
        {
            var manualMaterialBill = ManualMaterialBillRepository.GetBy(manualMaterialBillNo);
            manualMaterialBill.Production(manualMaterialBillDetailId);
        }

        #endregion

        public void DetailAdd(string maker, string manualMaterialBillNo, DateTime planBeginTime, DateTime planEndTime)
        {
        }

        public ManualMaterialBillModel GetManualMaterialBillOfExecuting(string employeeCode, string clientIP)
        {
            var isCheckEmployeeTeam = ParameterService.GetParameterValueBy<bool>("IsCheckEmployeeTeam", false);
            var machine = MachineRepository.GetMachine(clientIP);
            var manualMaterialBill = ManualMaterialBillRepository.GetManualMaterialBillOfExecuting(machine.MachineCode);

            if (isCheckEmployeeTeam)
            {
                var team = TeamService.GetTeamByMember(employeeCode);
                var manualMaterialBillDetail = manualMaterialBill.GetManualMaterialBillDetail(machine.MachineCode);

                if (manualMaterialBillDetail.TeamCode != team.TeamCode)
                {
                    throw new Exception($"生产计划号：{manualMaterialBill.ManualMaterialBillNo}所对应机组: {machine.MachineName}班组：{manualMaterialBillDetail.TeamName}与员工: {employeeCode} 所在班组: {team.TeamName}不一致，请检查！");
                }
            }

            return Mapper.Map<ManualMaterialBillModel>(manualMaterialBill);
        }
        
    }
}
