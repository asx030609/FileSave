/*
* 
*/
Ext.define('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillToolbar', {
    extend: 'Fusion.ux.toolbar.Basic',
    alias: 'widget.manualMaterialBillToolbar',

    requires: ['Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillModel'],
    viewModel: 'manualMaterialBill',

    moduleId: null,
    verifyText: '审核',
    batchVerifyText: '批量审核',
    reverifyText: '反审',
    taskText: '作业',
    batchTaskText: '批量作业',
    shiftText: '快捷添加',
    settleText: '结单',
    batchSettleText: '批量结单',
    showDetailText: '显示明细',

    initComponent: function () {
        var me = this,
            btnVerify, btnBatchVerify, btnReverify, btnTask, btnTask, btnDetailAdd, btnSettle, btnBatchSettle, chkShowDetail, txtQuickSearch;

        me.callParent(arguments);

        btnVerify = Ext.create('Ext.Button', {
            text: me.verifyText,
            iconCls: 'x-fa fa-paint-brush',
            itemId: 'btnVerify',
            disabled: true,
            handler: 'onVerifyClick',
            bind: {
                iconCls: '{functions.verify.FontIcon}',
                hidden: '{!functions.verify.Active}'
            }
        });

        btnBatchVerify = Ext.create('Ext.Button', {
            text: me.batchVerifyText,
            iconCls: 'x-fa fa-paint-brush',
            itemId: 'btnBatchVerify',
            disabled: true,
            handler: 'onBatchVerifyClick',
            bind: {
                iconCls: '{functions.verify.FontIcon}',
                hidden: '{!functions.verify.Active}'
            }
        });

        btnReverify = Ext.create('Ext.Button', {
            text: me.reverifyText,
            iconCls: 'x-fa fa-reply',
            itemId: 'btnReverify',
            disabled: true,
            handler: 'onReverifyClick',
            bind: {
                iconCls: '{functions.reverify.FontIcon}',
                hidden: '{!functions.reverify.Active}'
            }
        });

        btnTask = Ext.create('Ext.Button', {
            text: me.taskText,
            iconCls: 'x-fa fa-grav',
            itemId: 'btnTask',
            disabled: true,
            handler: 'onTaskClick',
            bind: {
                iconCls: '{functions.task.FontIcon}',
                hidden: '{!functions.task.Active}'
            }
        });

        btnBatchTask = Ext.create('Ext.Button', {
            text: me.batchTaskText,
            iconCls: 'x-fa fa-grav',
            itemId: 'btnBatchTask',
            disabled: true,
            handler: 'onBatchTaskClick',
            bind: {
                iconCls: '{functions.task.FontIcon}',
                hidden: '{!functions.task.Active}'
            }
        });

        btnDetailAdd = Ext.create('Ext.Button', {
            text: me.shiftText,
            iconCls: 'x-fa fa-copy',
            itemId: 'btnDetailAdd',
            disabled: true,
            handler: 'onDetailAddClick',
            bind: {
                iconCls: '{functions.detailAdd.FontIcon}',
                hidden: '{!functions.detailAdd.Active}'
            }
        });

        btnSettle = Ext.create('Ext.Button', {
            text: me.settleText,
            iconCls: 'x-fa fa-ravelry',
            itemId: 'btnSettle',
            disabled: true,
            handler: 'onSettleClick',
            bind: {
                iconCls: '{functions.settle.FontIcon}',
                hidden: '{!functions.settle.Active}'
            }
        });

        btnBatchSettle = Ext.create('Ext.Button', {
            text: me.batchSettleText,
            iconCls: 'x-fa fa-ravelry',
            itemId: 'btnBatchSettle',
            disabled: true,
            handler: 'onBatchSettleClick',
            bind: {
                iconCls: '{functions.settle.FontIcon}',
                hidden: '{!functions.settle.Active}'
            }
        });

        chkShowDetail = Ext.create('Ext.form.field.Checkbox', {
            boxLabel: me.showDetailText,
            itemId: 'chkShowDetail',
            inputValue: true,
            checked: true,
            uncheckedValue: false,
            listeners: {
                'change': 'onShowDetailChange'
            }
        });

        txtQuickSearch = Ext.create('Fusion.ux.form.field.QuickSearchField', {
            store: me.store,
            columns: me.columns
        });

        me.btnPrint.reportContract = 'ManualMaterialBillReport';
        me.btnExport.exportUrl = "/api/ManualMaterialBill/ExportManualMaterialBillExcel/";

        me.items = [
            me.btnRefresh,
            me.btnFind,
            me.btnAdd,
            me.btnModify,
            me.btnRemove,
            btnVerify,
            btnBatchVerify,
            btnReverify,
            btnTask,
            btnBatchTask,
            btnDetailAdd,
            btnSettle,
            btnBatchSettle,
            me.btnExport,
            me.btnPrint,
            me.btnHelp,
            '->',
            chkShowDetail,
            '->',
            txtQuickSearch,
            ' '
        ];

        me.callParent();
    }
});