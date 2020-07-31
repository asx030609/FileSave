/*
* 
*/
Ext.define("Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillContainer", {
    extend: "Ext.container.Container",
    alias: 'widget.manualMaterialBillContainer',

    requires: [
        'Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBill',
        'Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.ManualMaterialBillDetail'
    ],

    moduleId: null,
    manualMaterialBillTitle: '生产计划',
    manualMaterialBillDetail: '生产计划明细',

    layout: 'border',

    otherContent: [{
        type: 'ManualMaterialBill',
        path: 'extjs/fusion/classic/src/warehouse/view/bill/ManualMaterialBills/ManualMaterialBill.js'
    }, {
        type: 'Find',
        path: 'extjs/fusion/classic/src/warehouse/view/bill/ManualMaterialBills/FindManualMaterialBill.js'
    }, {
        type: 'Modify',
        path: 'extjs/fusion/classic/src/warehouse/view/bill/ManualMaterialBills/ModifyManualMaterialBill.js'
    }, {
        type: 'DetailAdd',
        path: 'extjs/fusion/classic/src/warehouse/view/bill/ManualMaterialBills/ShiftManualMaterialBill.js'
    }, {
        type: 'Store',
        path: 'extjs/fusion/classic/src/warehouse/store/bill/ManualMaterialBills/ManualMaterialBillStore.js'
    }, {
        type: 'Model',
        path: 'extjs/fusion/classic/src/warehouse/model/bill/ManualMaterialBills/ManualMaterialBillModel.js'
    }, {
        type: 'Controller',
        path: 'extjs/fusion/classic/src/warehouse/view/bill/ManualMaterialBills/ManualMaterialBillController.js'
    }, {
        type: 'ManualMaterialBillToolbar',
        path: 'extjs/fusion/classic/src/warehouse/view/bill/ManualMaterialBills/ManualMaterialBillToolbar.js'
    }, {
        type: 'ManualMaterialBillDetail',
        path: 'extjs/fusion/classic/src/warehouse/view/bill/ManualMaterialBills/ManualMaterialBillDetail/ManualMaterialBillDetail.js'
    }, {
        type: 'FindManualMaterialBillDetail',
        path: 'extjs/fusion/classic/src/warehouse/view/bill/ManualMaterialBills/ManualMaterialBillDetail/FindManualMaterialBillDetail.js'
    }, {
        type: 'ModifyManualMaterialBillDetail',
        path: 'extjs/fusion/classic/src/warehouse/view/bill/ManualMaterialBills/ManualMaterialBillDetail/ModifyManualMaterialBillDetail.js'
    }, {
        type: 'ManualMaterialBillDetailController',
        path: 'extjs/fusion/classic/src/warehouse/view/bill/ManualMaterialBills/ManualMaterialBillDetail/ManualMaterialBillDetailController.js'
    }, {
        type: 'ManualMaterialBillDetailToolbar',
        path: 'extjs/fusion/classic/src/warehouse/view/bill/ManualMaterialBills/ManualMaterialBillDetail/ManualMaterialBillDetailToolbar.js'
    }, {
        type: 'ManualMaterialBillDetailStore',
        path: 'extjs/fusion/classic/src/warehouse/store/bill/ManualMaterialBills/ManualMaterialBillDetailStore.js'
    }, {
        type: 'ManualMaterialBillModel',
        path: 'extjs/fusion/classic/src/warehouse/model/bill/ManualMaterialBills/ManualMaterialBillModel.js'
    }],

    listeners: {
        show: {
            single: true,
            fn: function () {
                var me = this,
                    grid, gridDetail;

                grid = me.down('manualMaterialBill');
                gridDetail = me.down('manualMaterialBillDetail');

                gridDetail.manualMaterialBillStatuses = grid.getController().manualMaterialBillStatuses;
            }
        }
    },

    initComponent: function () {
        var me = this;

        me.items = [{
            xtype: 'manualMaterialBill',
            region: 'center',
            border: false,
            header: false,
            moduleId: me.moduleId,
            title: me.manualMaterialBillTitle
        }, {
            xtype: 'manualMaterialBillDetail',
            region: 'south',
            height: '40%',
            split: {
                collapseOnDblClick: false
            },
            border: false,
            header: false,
            hidden: true,
            title: me.manualMaterialBillDetail
        }];

        me.callParent();
    }
});