/*
* 
*/
Ext.define('Fusion.warehouse.model.bill.ManualMaterialBills.ManualMaterialBillDetailModel', {
    extend: 'Ext.data.Model',
    identifier: 'uuid',
    idProperty: 'Id',

    requires: [
        'Ext.data.proxy.Rest',
        'Ext.data.identifier.Uuid'
    ],

    fields: [
        { name: 'Id', type: 'string', convert: null },
        { name: 'SerialNumber', type: 'int' },
        { name: 'ManualMaterialBillNo', type: 'string' },
        { name: 'TeamCode', type: 'string' },
        { name: 'TeamName', type: 'string' },
        { name: 'MachineCode', type: 'string' },
        { name: 'MachineName', type: 'string' },
        { name: 'BrandCode', type: 'string' },
        { name: 'BrandName', type: 'string' },
        { name: 'SyncMoveBillNo', type: 'string' },
        { name: 'ManualMaterialBillDetailStatus', type: 'string' },
        { name: 'ProductionBeginTime', type: 'string' },
        { name: 'ProductionEndTime', type: 'string' },
        { name: 'OriginWorkNo', type: 'string' },
        { name: 'CreateTime', type: 'string' },
        { name: 'UpdateTime', type: 'string' },
        { name: 'RowVersion', type: 'string' }
    ],

    proxy: {
        type: 'rest',

        api: {
            read: 'Api/ManualMaterialBill/FindManualMaterialBillDetail',
            create: 'Api/ManualMaterialBill/AddManualMaterialBillDetail',
            update: 'Api/ManualMaterialBill/ModifyManualMaterialBillDetail',
            destroy: 'Api/ManualMaterialBill/RemoveManualMaterialBillDetail'
        }
    },

    getName: function () {
        return this.get('MachineCode')
    }
});