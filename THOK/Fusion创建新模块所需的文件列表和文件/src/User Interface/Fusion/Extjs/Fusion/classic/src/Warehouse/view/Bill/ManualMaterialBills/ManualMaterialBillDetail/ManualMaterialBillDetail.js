/*
* 
*/
Ext.define('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.ManualMaterialBillDetail', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.manualMaterialBillDetail',

    requires: [
        'Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.ManualMaterialBillDetailController',
        'Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.ManualMaterialBillDetailToolbar',
        'Fusion.warehouse.store.bill.ManualMaterialBills.ManualMaterialBillDetailStore'
    ],
    uses: [
        'Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.FindManualMaterialBillDetail',
        'Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.ModifyManualMaterialBillDetail'
    ],

    moduleId: null,
    controller: 'manualMaterialBillDetail',

    serialNo: '流水号',
    manualMaterialBillNo: '计划单号',
    teamCode: '班组编码',
    teamName: '班组',
    machineCode: '机组编码',
    machineName: '机组',
    brandCode: '牌号编码',
    brandName: '牌号',
    syncMoveBillNo: '同步移库单',
    status: '单据状态',
    startTime: '作业开始时间',
    finishTime: '作业结束时间',
    originWorkNo: '来源工单号',
    createTime: '创建时间',
    updateTime: '更新时间',

    config: {
        manualMaterialBillNo: null,
        manualMaterialBill: null,
        id: null
    },

    multiColumnSort: true,
    selType: "checkboxmodel",
    selModel: {
        injectCheckbox: 1,
        mode: "MULTI",
        checkOnly: false
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

        me.manualMaterialBillDetailStatusStore = Ext.create('Fusion.CommonStore.setting.DictionaryDetailStore', {
            storeId: 'manualMaterialBillDetailStatusStore',
            proxy: { extraParams: { dictionaryKey: 'ManualMaterialBillDetailStatus' } }
        });

        me.columns = [
            { xtype: "rownumberer", align: 'center' },
            { header: 'Id', dataIndex: 'Id', hidden: true },
            { header: me.serialNo, dataIndex: 'SerialNumber', width: 100, filter: 'number' },
            { header: me.manualMaterialBillNo, dataIndex: 'ManualMaterialBillNo', hidden: true, filter: 'string', width: 100 },
            { header: me.teamCode, dataIndex: 'TeamCode', filter: 'string', hidden: true, width: 100 },
            { header: me.teamName, dataIndex: 'TeamName', filter: 'string', width: 150 },
            { header: me.machineCode, dataIndex: 'MachineCode', hidden: true, filter: 'string', width: 100 },
            { header: me.machineName, dataIndex: 'MachineName', quickSearch: true, width: 150, filter: 'string' },
            { header: me.brandCode, dataIndex: 'BrandCode', hidden: true, filter: 'string', width: 100 },
            { header: me.brandName, dataIndex: 'BrandName', quickSearch: true, width: 150, filter: 'string' },
            { header: me.syncMoveBillNo, dataIndex: 'SyncMoveBillNo', hidden: true, filter: 'string', width: 100 },
            {
                header: me.status, dataIndex: 'ManualMaterialBillDetailStatus', width: 100,
                filter: {
                    type: 'list',
                    store: me.manualMaterialBillDetailStatusStore,
                    idField: 'Value',
                    labelField: 'Name'
                },
                renderer: function (value) {
                    record = me.manualMaterialBillDetailStatusStore.findRecord('Value', value);
                    return record == null ? value : record.data.Name;
                }
            },
            { header: me.startTime, dataIndex: 'ProductionBeginTime', width: 130, xtype: 'datecolumn', format: 'Y/m/d H:i:s', filter: 'date' },
            { header: me.finishTime, dataIndex: 'ProductionEndTime', width: 130, xtype: 'datecolumn', format: 'Y/m/d H:i:s', filter: 'date' },
            { header: me.originWorkNo, dataIndex: 'OriginWorkNo', width: 200, filter: 'string' },
            { header: me.createTime, dataIndex: 'CreateTime', xtype: 'datecolumn', width: 130, hidden: true, format: 'Y/m/d H:i:s', filter: 'date' }, 
            { header: me.updateTime, dataIndex: 'UpdateTime', xtype: 'datecolumn', width: 130, hidden: true, format: 'Y/m/d H:i:s', filter: 'date' }
        ];

        me.store = Ext.create('Fusion.warehouse.store.bill.ManualMaterialBills.ManualMaterialBillDetailStore');

        me.dockedItems = [{
            xtype: 'manualMaterialBillDetailToolbar',
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
        this.manualMaterialBillDetailStatusStore = Ext.destroy(this.manualMaterialBillDetailStatusStore);

        this.callParent();
    }
});