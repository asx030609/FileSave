/*
* 
*/
Ext.define('Fusion.warehouse.store.bill.ManualMaterialBills.ManualMaterialBillDetailStore', {
    extend: 'Ext.data.Store',

    model: 'Fusion.warehouse.model.bill.ManualMaterialBills.ManualMaterialBillDetailModel',

    autoLoad: false,
    remoteFilter: true,
    remoteSort: true,

    listeners: {
        beforeload: function (store, operation, eOpts) {
            var extraParams = store.getProxy().extraParams;
            if (!extraParams) {
                return false;
            }
            if (!extraParams.manualMaterialBillNo) {
                return false;
            }
            return true;
        }
    },

    sorters: [{
        property: 'SerialNumber',
        direction: 'DESC'
    }]
});