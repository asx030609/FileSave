/*
* 
*/
Ext.define('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.ManualMaterialBillDetailToolbar', {
    extend: 'Fusion.ux.toolbar.Basic',
    alias: 'widget.manualMaterialBillDetailToolbar',

    requires: [
        'Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.ManualMaterialBillDetailToolbar',
        'Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillModel'
    ],

    viewModel: 'manualMaterialBill',
    prefix: 'p_',

    productionText: '生产',

    initComponent: function () {
        var me = this, btnAdd, btnProduction, btnChangeShift,
            btnChangeBrand, btnComplete, txtQuickSearch;

        me.callParent(arguments);

        btnProduction = Ext.create('Ext.Button', {
            text: me.productionText,
            iconCls: 'x-fa fa-caret-square-o-right',
            itemId: 'btnProduction',
            disabled: true,
            handler: 'onProductionClick',
            bind: {
                iconCls: '{functions.p_production.FontIcon}',
                hidden: '{!functions.p_production.Active}'
            }
        });

        txtQuickSearch = Ext.create('Fusion.ux.form.field.QuickSearchField', {
            store: me.store,
            columns: me.columns
        });

        me.btnPrint.reportContract = 'ManualMaterialBillDetailReport';
        me.btnExport.exportUrl = "/api/ManualMaterialBill/ExportManualMaterialBillDetailExcel/";

        me.items = [
            me.btnRefresh,
            me.btnFind,
            me.btnAdd,
            me.btnModify,
            me.btnRemove,
            btnProduction,
            me.btnExport,
            me.btnPrint,
            me.btnHelp,
            '->',
            txtQuickSearch,
            ' '
        ];

        me.callParent();
    }
})