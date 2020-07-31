using AutoMapper;
using Fusion.Context.Warehouse.Application.Models.Bill.ManualMaterialBills;
using Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills;

/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Context.Warehouse.Application.Models.Configuration.Bill.ManualMaterialBills
{
    public class ManualMaterialBillDetailProfile : Profile
    {
        public ManualMaterialBillDetailProfile()
        {
            this.CreateMap<ManualMaterialBillDetail, ManualMaterialBillDetailModel>();
            this.CreateMap<ManualMaterialBillDetailModel, ManualMaterialBillDetail>();
        }
    }
}
