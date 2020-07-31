/*
* 
*/
Ext.define('Fusion.warehouse.store.bill.ManualMaterialBills.ManualMaterialBillStore', {
    extend: 'Ext.data.Store',

    model: 'Fusion.warehouse.model.bill.ManualMaterialBills.ManualMaterialBillModel',

    autoLoad: true,
    remoteFilter: true,
    remoteSort: true,

    sorters: [{
        property: 'ManualMaterialBillNo',
        direction: 'DESC'
    }]
});