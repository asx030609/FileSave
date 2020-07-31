/*
* 
*/
Ext.define('Fusion.warehouse.model.bill.ManualMaterialBills.ManualMaterialBillModel', {
    extend: 'Ext.data.Model',
    idProperty: 'ManualMaterialBillNo',

    requires: [
        'Ext.data.proxy.Rest'
    ],

    fields: [
        { name: 'ManualMaterialBillNo', type: 'string' },
        {
            name: 'PlanBeginTime', type: 'string',
            convert: function (value) {
                if (null != value) {
                    return Ext.Date.format(new Date(value), 'Y/m/d H:i:s');
                } else {
                    return null;
                }
            }
        },
        {
            name: 'PlanEndTime', type: 'string',
            convert: function (value) {
                if (null != value) {
                    return Ext.Date.format(new Date(value), 'Y/m/d H:i:s');
                } else {
                    return null;
                }
            }
        },
        { name: 'ManualMaterialBillStatus', type: 'string' },
        { name: 'Maker', type: 'string' },
        { name: 'MakeTime', type: 'string' },
        { name: 'Auditor', type: 'string' },
        { name: 'AuditTime', type: 'string' },
        { name: 'OriginPlanNo', type: 'string' },
        { name: 'ManualMaterialBillOrigin', type: 'string' },
        { name: 'CreateTime', type: 'string' },
        { name: 'UpdateTime', type: 'string' },
        { name: 'RowVersion', type: 'string' }
    ],

    proxy: {
        type: 'rest',

        api: {
            read: 'Api/ManualMaterialBill/Find',
            create: 'Api/ManualMaterialBill/Add',
            update: 'Api/ManualMaterialBill/Modify',
            destroy: 'Api/ManualMaterialBill/Remove'
        }
    },

    getName: function () {
        return this.get('ManualMaterialBillNo')
    }
});