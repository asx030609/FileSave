using AutoMapper;
using Fusion.Context.Warehouse.Application.Models.Bill;
using Fusion.Context.Warehouse.Application.Models.Bill.ManualMaterialBills;
using Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills;
using Fusion.Context.Warehouse.Domain.Models.Values;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Context.Warehouse.Application.Models.Configuration.Bill.ManualMaterialBills
{
    public class ManualMaterialBillProfile : Profile
    {
        public ManualMaterialBillProfile()
        {
            this.CreateMap<ManualMaterialBill, ManualMaterialBillModel>();

            this.CreateMap<ManualMaterialBillModel, ManualMaterialBill>()
                .ForMember(t => t.MakeTime, opt => opt.Ignore());
            //.ForMember(des => des.ManualMaterialBillDetails, opt => opt.Ignore());

            this.CreateMap<WorkOrderModel, WorkOrder>();
        }
    }
}
