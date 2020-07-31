/*
* 2018-06-05 Create by hongwanzhen
*/
Ext.define('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.ManualMaterialBillDetailController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.manualMaterialBillDetail',

    requires: [
        'Ext.window.Toast'
    ],
    uses: [
        'Fusion.common.view.machine.MachineController',
        'Fusion.common.view.brand.BrandController'
    ],

    billNoTitle: '单号:',
    findTitle: '查询',
    addTitle: '添加',
    modifyTitle: '修改',
    removeTitle: '删除',
    duplicateTip: '请先选择一条记录，然后再执行此操作',
    productionTitle: '生产',
    productionTip: '确定要生产吗？',
    productionSuccess: '生产成功！',
    changeShfitTitle: '换班',
    changeShfitTip: '确定要换班吗？',
    changeShfitSuccess: '换班成功！',
    changeBrandTitle: '换牌',
    changeBrandTip: '确定要换牌吗？',
    changeBrandSuccess: '换牌成功！',
    completeTitle: '完成',
    completeTip: '确认完成吗？',
    completeSuccess: '已完成！',

    setManualMaterialBill: function (manualMaterialBillRecord, hidden) {
        var me = this,
            grid, store;

        grid = me.getView();
        store = grid.getStore();

        grid.setHidden(hidden);
        if (grid.isVisible() == false) {
            return;
        }
        if (manualMaterialBillRecord == null) {
            store.removeAll();
        }
        else {
            grid.manualMaterialBill= manualMaterialBillRecord;
            store.getProxy().extraParams.manualMaterialBillNo = manualMaterialBillRecord.get('ManualMaterialBillNo');
            store.reload();

            getStatus = manualMaterialBillRecord.data.ManualMaterialBillStatus;
            me.setButtonManualMaterialBillDetail(getStatus);
        }
    },

    onSelectionChange: function (model, selected, eOpts) {
        var me = this,
            grid, btnRemove, btnModify, viewModel,
            manualMaterialBill, getStatus, manualMaterialBillStatus;

        grid = me.getView();
        manualMaterialBill= grid.manualMaterialBill;
        if (manualMaterialBill== null) {
            return;
        }

        getStatus = manualMaterialBill.get("ManualMaterialBillStatus");
        me.setButtonManualMaterialBillDetail(getStatus);
    },

    onRefreshClick: function () {
        var store = this.getView().getStore();

        store.reload();
    },

    onFindClick: function () {
        var me = this,
            grid, store, form, window, manualMaterialBillNo;

        grid = me.getView();
        manualMaterialBillNo = grid.manualMaterialBill.get('ManualMaterialBillNo');
        store = grid.getStore();
        form = Ext.create('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.FindManualMaterialBillDetail');
        window = Fusion.findWindow({
            grid: grid,
            items: form,
            title: me.findTitle + '-' + grid.getTitle() + '【' + me.billNoTitle + manualMaterialBillNo + '】'
        });

        window.show();
    },

    onAddClick: function () {
        var me = this,
            grid, manualMaterialBillNo, form, window, billNo;

        grid = me.getView();
        manualMaterialBillNo = grid.manualMaterialBill.get('ManualMaterialBillNo');

        form = Ext.create('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.AddManualMaterialBillDetail');
        window = Fusion.addWindow({
            grid: grid,
            items: form,
            title: me.addTitle + '-' + grid.getTitle() + '【' + me.billNoTitle + manualMaterialBillNo + '】'
        });

        window.show();
    },

    onDuplicateClick: function () {
        var me = this,
            grid, manualMaterialBillNo, selection, form, window, billNo;

        grid = me.getView();
        manualMaterialBillNo = grid.manualMaterialBill.get('ManualMaterialBillNo');
        selection = grid.getSelectionModel().getSelection();

        if (selection.length != 1) {
            Fusion.toast(me.duplicateTip + '!')
            return;
        };

        form = Ext.create('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.ModifyManualMaterialBillDetail');
        window = Fusion.addWindow({
            grid: grid,
            items: form,
            title: me.addTitle + '-' + grid.getTitle() + '【' + me.billNoTitle + manualMaterialBillNo + '】'
        });
        form.loadRecord(selection[0]);

        window.show();
    },

    onModifyClick: function (button) {
        var me = this,
            grid, manualMaterialBillNo, model, form, window, billNo;

        grid = me.getView();
        manualMaterialBillNo = grid.manualMaterialBill.get('ManualMaterialBillNo');
        model = grid.getSelectionModel().getSelection()[0];

        form = Ext.create('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.ModifyManualMaterialBillDetail');
        window = Fusion.modifyWindow({
            grid: grid,
            items: form,
            title: me.modifyTitle + '-' + grid.getTitle() + '【' + me.billNoTitle + manualMaterialBillNo + '】'
        });
        form.loadRecord(model);

        window.show();
    },

    onRemoveClick: function (button) {
        var me = this,
            grid, manualMaterialBillNo, title;

        grid = me.getView();
        manualMaterialBillNo = grid.manualMaterialBill.get('ManualMaterialBillNo');
        title = me.removeTitle + '-' + grid.getTitle() + '【' + me.billNoTitle + manualMaterialBillNo + '】';
        Fusion.Msg.remove({
            grid: grid,
            title: title
        });
    },

    onProductionClick: function () {
        var me = this,
            windowTitle, message, postUrl, successMsg;

        windowTitle = me.productionTitle;
        message = me.productionTip;
        postUrl = 'Api/ManualMaterialBill/Production';
        successMsg = me.productionSuccess;
        me.buttonClickPost(windowTitle, message, postUrl, successMsg);
    },

    onCompleteClick: function () {
        var me = this,
            windowTitle, message, postUrl, successMsg;

        windowTitle = me.completeTitle;
        message = me.completeTip;
        postUrl = 'Api/ManualMaterialBill/Complete';
        successMsg = me.completeSuccess;
        me.buttonClickPost(windowTitle, message, postUrl, successMsg);
    },

    buttonClickPost: function (windowTitle, message, postUrl, successMsg) {
        var me = this,
            grid, store, model, record, rowCount, selection, message, serialNumber;

        grid = me.getView();
        store = grid.getStore();
        model = grid.getSelectionModel();
        selection = model.getSelection();
        manualMaterialBillNo = selection[0].data.ManualMaterialBillNo;
        manualMaterialBillDetailId = selection[0].data.Id;
        Ext.Msg.confirm(windowTitle, message, function (btn) {
            if (btn == 'yes') {
                Ext.Ajax.request({
                    url: postUrl,
                    params: {
                        manualMaterialBillNo: manualMaterialBillNo,
                        manualMaterialBillDetailId: manualMaterialBillDetailId
                    },
                    method: 'GET',
                    async: false,
                    success: function (response) {
                        var result = Ext.decode(response.responseText);
                        if (result.success) {
                            Fusion.toast(successMsg);

                            model.clearSelections();
                            store.reload({
                                callback: function () {
                                    var rowCount = store.getCount();
                                    for (var i = 0; i < rowCount; i++) {
                                        if (store.getAt(i).get("ManualMaterialBillNo") == manualMaterialBillNo) {
                                            record = store.getAt(i);
                                            model.select(record, true);
                                            return;
                                        }
                                    }
                                }
                            });
                        }
                    }
                })
            }
        });
    },

    setButtonManualMaterialBillDetail: function (getStatus) {
        var me = this,
            grid, btnAdd, btnModify, btnRemove, btnProduction, btnChangeShift,
            btnChangeBrand, btnComplete, viewModel, manualMaterialBillStatuses, selected;

        grid = me.getView();
        manualMaterialBillStatuses = grid.manualMaterialBillStatuses;

        viewModel = grid.down('toolbar').viewModel;
        selected = grid.getSelectionModel().getSelection().length;

        btnAdd = grid.down('toolbar button#btnAdd');
        btnModify = grid.down('toolbar button#btnModify');
        btnRemove = grid.down('toolbar button#btnRemove');
        btnProduction = grid.down('toolbar button#btnProduction');

        if (btnAdd) {
            btnAdd[getStatus == manualMaterialBillStatuses.Entered
                && viewModel.get('functions.p_add.IsAuthenticated')
                ? 'enable'
                : 'disable']();
        }

        if (btnModify) {
            btnModify[selected == 1
                && viewModel.get('functions.p_modify.IsAuthenticated')
                && getStatus == manualMaterialBillStatuses.Entered
                ? 'enable'
                : 'disable']();
        }

        if (btnRemove) {
            btnRemove[selected > 0
                && viewModel.get('functions.p_remove.IsAuthenticated')
                && getStatus == manualMaterialBillStatuses.Entered
                ? 'enable'
                : 'disable']();
        }

        if (btnProduction) {
            btnProduction[selected == 1
                && viewModel.get('functions.p_production.IsAuthenticated')
                && getStatus == manualMaterialBillStatuses.Executing
                ? 'enable'
                : 'disable']();
        }
    },

    onComboChange: function (combo, newValue, oldValue, eOpts) {
        if (newValue) {
            combo.getTrigger('clear').show();
        } else {
            combo.getTrigger('clear').hide();
        }
    },

    onComboClearTriggerClick: function (combo) {
        combo.setValue();
    },

    onMachineCodeChange: function (combo, newValue) {
        var form, record, stationName, workPositionNo;

        form = combo.up('form').getForm();
        machineName = form.findField('MachineName');
        if (newValue) {
            machineName.setValue(combo.getRawValue());
        }
    },

    onBrandSearchClick: function (textfield) {
        var controller;

        controller = Ext.create('Fusion.common.view.brand.BrandController');
        var collection = Ext.create('Ext.util.MixedCollection');
        collection.add('BrandCode', 'BrandCode');
        collection.add('BrandName', 'BrandName');
        controller.onBrandSearchClick(textfield, collection);
    },

    onMachineSearchClick: function (textfield) {
        var controller;

        controller = Ext.create('Fusion.common.view.machine.MachineNoIpController');
        var collection = Ext.create('Ext.util.MixedCollection');
        collection.add('MachineCode', 'MachineCode');
        collection.add('MachineName', 'MachineName');
        controller.onMachineFieldClick(textfield, collection);
    }

});
