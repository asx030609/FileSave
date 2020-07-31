/*
* 2020-07-31 Create by wuzuqiang
*/
namespace Fusion.Context.Warehouse.Domain.Models.Bill.ManualMaterialBills
{
    public enum ManualMaterialBillDetailStatus
    {
        Wait = 0,
        Production = 1,
        ChangeShift = 2,
        ChangeBrand = 3,
        Complete = 4
    }
}
