/*
* 
*/
Ext.define('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBill', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.manualMaterialBill',

    requires: [
        'Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillController',
        'Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillToolbar',
        'Fusion.warehouse.store.bill.ManualMaterialBills.ManualMaterialBillStore'
    ],
    uses: [
        'Fusion.warehouse.view.bill.ManualMaterialBills.FindManualMaterialBill',
        'Fusion.warehouse.view.bill.ManualMaterialBills.ModifyManualMaterialBill'
    ],

    moduleId: null,

    manualMaterialBillTitle: '生产计划',
    manualMaterialBillNo: '计划单号',
    planBeginTime: '计划开始时间',
    planEndTime: '计划结束时间',
    manualMaterialBillStatus: '单据状态',
    maker: '制单人',
    makeTime: '制单时间',
    auditor: '审核人',
    auditTime: '审核时间',
    manualMaterialBillOrigin: '计划来源',
    originPlanNo: '来源单号',
    createTime: '创建时间',
    updateTime: '更新时间',

    controller: 'manualMaterialBill',
    stateful: true,
    stateId: 'state.manualMaterialBill',
    selType: 'checkboxmodel',
    multiColumnSort: true,
    selModel: {
        injectCheckbox: 1,
        mode: "MULTI",
        checkOnly: false
    },

    config: {
        manualMaterialBill: null,
        manualMaterialBillNo: null,
        planStatus: null
    },

    plugins: [
        'gridfilters',
        'gridexporter'
    ],

    listeners: {
        selectionChange: 'onSelectionChange'
    },

    initComponent: function () {
        var me = this,
            record;

        me.manualMaterialBillStatusStore = Ext.create('Fusion.CommonStore.setting.DictionaryDetailStore', {
            storeId: 'manualMaterialBillStatusStore',
            proxy: { extraParams: { dictionaryKey: 'ManualMaterialBillStatus' } }
        });

        me.manualMaterialBillOriginStore = Ext.create('Fusion.CommonStore.setting.DictionaryDetailStore', {
            storeId: 'manualMaterialBillOriginStore',
            proxy: { extraParams: { dictionaryKey: 'ManualMaterialBillOrigin' } }
        });

        me.title = me.manualMaterialBillTitle;

        me.columns = [
            { xtype: "rownumberer", align: 'center' },
            { header: me.manualMaterialBillNo, dataIndex: 'ManualMaterialBillNo', quickSearch: true, filter: 'string', width: 100 },
            { header: me.planBeginTime, dataIndex: 'PlanBeginTime', xtype: 'datecolumn', format: 'Y/m/d H:i:s', width: 130, filter: 'date' },
            { header: me.planEndTime, dataIndex: 'PlanEndTime', xtype: 'datecolumn', format: 'Y/m/d H:i:s', width: 130, filter: 'date' },
            { header: me.maker, dataIndex: 'Maker', filter: 'string', width: 100 },
            { header: me.makeTime, dataIndex: 'MakeTime', xtype: 'datecolumn', format: 'Y/m/d H:i:s', width: 130, filter: 'date' },
            { header: me.auditor, dataIndex: 'Auditor', filter: 'string', width: 100 },
            { header: me.auditTime, dataIndex: 'AuditTime', xtype: 'datecolumn', format: 'Y/m/d H:i:s', width: 130, filter: 'date' },
            {
                header: me.manualMaterialBillStatus, dataIndex: 'ManualMaterialBillStatus', width: 100,
                filter: {
                    type: 'list',
                    store: me.manualMaterialBillStatusStore,
                    idField: 'Value',
                    labelField: 'Name'
                },
                renderer: function (value) {
                    record = me.manualMaterialBillStatusStore.findRecord('Value', value);
                    return record == null ? value : record.data.Name;
                }
            },
            {
                header: me.manualMaterialBillOrigin, dataIndex: 'ManualMaterialBillOrigin', width: 100,
                filter: {
                    type: 'list',
                    store: me.manualMaterialBillOriginStore,
                    idField: 'Value',
                    labelField: 'Name'
                },
                renderer: function (value) {
                    record = me.manualMaterialBillOriginStore.findRecord('Value', value);
                    return record == null ? value : record.data.Name;
                }
            },
            { header: me.originPlanNo, dataIndex: 'OriginPlanNo', hidden: false, width: 130, filter: 'string' },
            { header: me.createTime, dataIndex: 'CreateTime', xtype: 'datecolumn', hidden: true, width: 130, format: 'Y/m/d H:i:s', filter: 'date' },
            { header: me.updateTime, dataIndex: 'UpdateTime', xtype: 'datecolumn', hidden: true, width: 130, format: 'Y/m/d H:i:s', filter: 'date' }
        ];

        me.store = Ext.create('Fusion.warehouse.store.bill.ManualMaterialBills.ManualMaterialBillStore');

        me.dockedItems = [{
            xtype: 'manualMaterialBillToolbar',
            dock: 'top',
            moduleId: me.moduleId,
            store: me.store,
            columns: me.columns
        }, {
            xtype: 'pagingtoolbar',
            dock: 'bottom',
            displayInfo: true,
            store: me.store
        }];

        me.callParent();
    },

    destroy: function () {
        this.manualMaterialBillStatusStore = Ext.destroy(this.manualMaterialBillStatusStore);
        this.manualMaterialBillOriginStore = Ext.destroy(this.manualMaterialBillOriginStore);

        this.callParent();
    }
});