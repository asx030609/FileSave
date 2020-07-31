/*
* 
*/
Ext.define('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillController', {
    extend: 'Ext.app.ViewController',
    alias: 'controller.manualMaterialBill',

    requires: [
        'Ext.window.Toast'
    ],
    uses: [
        'Fusion.common.view.team.TeamController'
    ],

    labelWidth: 70,
    modifyTitle: '修改',
    duplicateTip: '请先选择一条记录，然后再执行此操作',
    removeTitle1: "提示框",
    removeFail: '所选择的单据已存在细表或不是已录入状态！无法删除！',
    removeFail1: '以下的 {lenght} 条单据不是【已录入】状态，无法删除！',
    verifyTitle: '审核',
    verifyTip: '确认要审核该记录吗？',
    verifySuccess: '审核成功！',
    batchVerifyTitle: '批量审核',
    batchVerifyTip: '确认要批量审核该记录吗？',
    batchVerifySuccess: '批量审核成功！',
    reverifyTitle: '反审',
    reverifyTip: '确认要反审该记录吗？',
    reverifySuccess: '反审成功！',
    taskTitle: '作业',
    taskTip: '确认要执行生产作业操作吗？作业后该生产计划无法取消！',
    taskSuccess: '作业成功！',
    shiftTitle: '快捷添加',
    shiftTip: '确认将选中的生产计划明细添加到其它班组？',
    shiftSuccess: '添加成功！',
    saveTitle: '保存',
    settleTitle: '结单',
    batchSettleTitle: '批量结单',
    settleTip: '确认要结单吗？单结后将无法再操作！请谨慎操作！',
    settleSuccess: '结单成功！',

    manualMaterialBillStatuses: {
        Entered: 0,
        Audited: 1,
        Executing: 2,
        Settled: 3
    },

    getClassesStore: function () {
        var classesStore = Ext.create('Ext.data.Store', {
            fields: ['key', 'value'],
            data: [
                { 'key': '(1)', 'value': '08:30:00--16:30:00' },
                { 'key': '(2)', 'value': '16:30:00--00:30:00' },
                { 'key': '(3)', 'value': '00:30:00--08:30:00' },
                { 'key': '(4)', 'value': '00:00:00--23:59:59' }
            ]
        });
        return classesStore;
    },

    setManualMaterialBill: function (manualMaterialBills) {
        var me = this,
            grid;

        grid = me.getView();

        if (manualMaterialBills != null && manualMaterialBills.length == 1) {
            grid.manualMaterialBill= manualMaterialBills[0];
            grid.manualMaterialBillNo = grid.manualMaterialBill.get("ManualMaterialBillNo");
            grid.manualMaterialBillStatus = grid.manualMaterialBill.get("ManualMaterialBillStatus");
        }
        else {
            grid.manualMaterialBill= null;
            grid.manualMaterialBillNo = null;
            grid.manualMaterialBillStatus = null;
        }
    },

    batchSetManualMaterialBill: function (manualMaterialBills) {
        var me = this,
            grid, planStatus;

        grid = me.getView();
        
        if (manualMaterialBills != null && manualMaterialBills.length > 1) {
            var allSame = true;
            for (var i = 0; i < manualMaterialBills.length; i++) {

                grid.manualMaterialBill= manualMaterialBills[i];
                grid.manualMaterialBillNo = grid.manualMaterialBill.get("ManualMaterialBillNo");
                grid.manualMaterialBillStatus = grid.manualMaterialBill.get("ManualMaterialBillStatus");

                if (i == 0) {
                    planStatus = grid.manualMaterialBillStatus;
                }

                if (planStatus != grid.manualMaterialBillStatus) {
                    allSame = false;
                    break;
                }
            }

            if (!allSame) {
                grid.manualMaterialBill= null;
                grid.manualMaterialBillNo = null;
                grid.manualMaterialBillStatus = null;
            }
        }
    },

    onSelectionChange: function (model, selected, eOpts) {
        var me = this;

        if (selected.length == 1)
        {
            me.setManualMaterialBill(selected);
        }
        if (selected.length > 1) {
            me.batchSetManualMaterialBill(me.getView().getSelectionModel().getSelection());
        }
        me.controlToolButtonStatus();
        me.controlManualMaterialBillDetailState();
    },

    controlToolButtonStatus: function () {
        var me = this,
            grid, btnRemove, btnModify, btnVerify, btnBatchVerify, btnTask, btnBatchTask, btnReverify, btnDetailAdd, btnSettle, btnBatchSettle, viewModel, manualMaterialBillStatus;

        grid = me.getView();
        selected = grid.getSelectionModel().getSelection();
        manualMaterialBillStatus = grid.manualMaterialBillStatus;

        viewModel = grid.down('toolbar').viewModel;
        btnModify = grid.down('toolbar button#btnModify');
        btnDetailAdd = grid.down('toolbar button#btnDetailAdd');
        btnRemove = grid.down('toolbar button#btnRemove');
        btnVerify = grid.down('toolbar button#btnVerify');
        btnBatchVerify = grid.down('toolbar button#btnBatchVerify');
        btnReverify = grid.down('toolbar button#btnReverify');
        btnTask = grid.down('toolbar button#btnTask');
        btnBatchTask = grid.down('toolbar button#btnBatchTask');
        btnSettle = grid.down('toolbar button#btnSettle');
        btnBatchSettle = grid.down('toolbar button#btnBatchSettle');

        if (btnModify) {
            btnModify[selected.length == 1
                && viewModel.get('functions.modify.IsAuthenticated')
                && manualMaterialBillStatus == me.manualMaterialBillStatuses.Entered
                ? 'enable'
                : 'disable']();
        }

        if (btnRemove) {
            btnRemove[selected.length > 0
                && viewModel.get('functions.remove.IsAuthenticated')
                && manualMaterialBillStatus == me.manualMaterialBillStatuses.Entered
                ? 'enable'
                : 'disable']();
        }

        if (btnVerify) {
            btnVerify[selected.length == 1
                && viewModel.get('functions.verify.IsAuthenticated')
                && manualMaterialBillStatus == me.manualMaterialBillStatuses.Entered
                ? 'enable'
                : 'disable']();
        }

        if (btnBatchVerify) {
            btnBatchVerify[viewModel.get('functions.verify.IsAuthenticated')
                && manualMaterialBillStatus == me.manualMaterialBillStatuses.Entered
                ? 'enable'
                : 'disable']();
        }

        if (btnReverify) {
            btnReverify[selected.length == 1
                && viewModel.get('functions.reverify.IsAuthenticated')
                && manualMaterialBillStatus == me.manualMaterialBillStatuses.Audited
                ? 'enable'
                : 'disable']();
        }

        if (btnTask) {
            btnTask[selected.length == 1
                && viewModel.get('functions.task.IsAuthenticated')
                && (manualMaterialBillStatus == me.manualMaterialBillStatuses.Audited)
                ? 'enable'
                : 'disable']();
        }

        if (btnBatchTask) {
            btnBatchTask[viewModel.get('functions.task.IsAuthenticated')
                && (manualMaterialBillStatus == me.manualMaterialBillStatuses.Audited)
                ? 'enable'
                : 'disable']();
        }

        if (btnDetailAdd) {
            btnDetailAdd[selected.length == 1
                && viewModel.get('functions.detailAdd.IsAuthenticated')
                && (manualMaterialBillStatus == me.manualMaterialBillStatuses.Audited
                    || manualMaterialBillStatus == me.manualMaterialBillStatuses.Executing)
                ? 'enable'
                : 'disable']();
        }

        if (btnSettle) {
            btnSettle[selected.length == 1
                && viewModel.get('functions.settle.IsAuthenticated')
                && manualMaterialBillStatus == me.manualMaterialBillStatuses.Executing
                ? 'enable'
                : 'disable']();
        }

        if (btnBatchSettle) {
            btnBatchSettle[ viewModel.get('functions.settle.IsAuthenticated')
                && manualMaterialBillStatus == me.manualMaterialBillStatuses.Executing
                ? 'enable'
                : 'disable']();
        }
    },

    controlManualMaterialBillDetailState: function () {
        var me = this,
            grid, gridDetail,
            showDetail, hidden;

        grid = me.getView();
        gridDetail = grid.next('manualMaterialBillDetail');
        showDetail = grid.down('toolbar checkbox#chkShowDetail').getValue();
        hidden = (grid.manualMaterialBill!= null && showDetail == true) == false;

        gridDetail.getController().setManualMaterialBill(grid.manualMaterialBill, hidden);
    },

    onRefreshClick: function () {
        var store = this.getView().getStore();

        store.reload();
    },

    onFindClick: function () {
        var me = this, grid, form, window;

        grid = me.getView();
        store = grid.getStore();
        form = Ext.create('Fusion.warehouse.view.bill.ManualMaterialBills.FindManualMaterialBill');
        window = Fusion.findWindow({
            grid: grid,
            items: form
        });
        window.show();
    },

    onAddClick: function () {
        var me = this, grid, form, window, warehouseCombo, stationCombo, billTypeCombo;

        grid = me.getView();
        form = Ext.create('Fusion.warehouse.view.bill.ManualMaterialBills.ModifyManualMaterialBill');
        window = Fusion.addWindow({
            grid: grid,
            items: form
        });
        form.getForm().findField('Classes').setStore(me.getClassesStore());

        window.show();
    },

    onDuplicateClick: function () {
        var me = this, grid, selection, form, window;

        grid = me.getView();
        selection = grid.getSelectionModel().getSelection();

        if (selection.length != 1) {
            Fusion.toast(me.duplicateTip + '!')
            return;
        };

        form = Ext.create('Fusion.warehouse.view.bill.ManualMaterialBills.ModifyManualMaterialBill');
        window = Fusion.addWindow({
            grid: grid,
            items: form
        });
        form.loadRecord(selection[0]);
        form.getForm().findField('ManualMaterialBillNo').setValue('');
        form.getForm().findField('Classes').setStore(me.getClassesStore());

        window.show();
    },

    onModifyClick: function (button) {
        var me = this, grid, model, form, manualMaterialBillNo, window;

        grid = me.getView();
        model = grid.getSelectionModel().getSelection()[0];
        selection = grid.getSelectionModel().getSelection();
        manualMaterialBillNo = model.get('ManualMaterialBillNo');
        form = Ext.create('Fusion.warehouse.view.bill.ManualMaterialBills.ModifyManualMaterialBill');
        window = Fusion.modifyWindow({
            grid: grid,
            title: me.modifyTitle + '-' + grid.getTitle() + '【' + manualMaterialBillNo + '】',
            items: form
        });
        form.loadRecord(model);
        form.getForm().findField('Classes').setStore(me.getClassesStore());

        window.show();
    },

    onRemoveClick: function (button) {
        var me = this,
            grid, manualMaterialBillStatus, manualMaterialBillDetailStatus, flag,
            onCheckSingleRecord, onCheckMultiRecords;

        grid = me.getView();
        statusMsg = '<ol>';
        flag = 0;

        onCheckSingleRecord = function (record) {
            manualMaterialBillStatus = record.get("ManualMaterialBillStatus");
            serialNo = record.get("ManualMaterialBillDetailStatus");

            if (manualMaterialBillStatus != me.manualMaterialBillStatuses.Entered) {
                Fusion.toast(me.removeFail);
                return false;
            }
        };

        onCheckMultiRecords = function () {
            statusMsg += '</ol>';
            if (flag > 0) {
                statusMsg = me.removeFail1.replace('{lenght}', flag) + statusMsg;
                Ext.Msg.alert(me.removeTitle1, statusMsg);
                return false;
            }
        }

        Fusion.Msg.remove({
            grid: grid,
            onCheckSingleRecord: onCheckSingleRecord,
            onCheckMultiRecords: onCheckMultiRecords
        })
    },

    onShowDetailChange: function (checkbox, newValue, oldValue, eOpts) {
        var me = this;

        me.controlManualMaterialBillDetailState();
    },

    onVerifyClick: function () {
        var me = this,
            windowTitle, message, postUrl, successMsg;

        windowTitle = me.verifyTitle;
        message = me.verifyTip;
        postUrl = 'Api/ManualMaterialBill/Verify';
        successMsg = me.verifySuccess;
        me.buttonClickPost(windowTitle, message, postUrl, successMsg);
    },

    onBatchVerifyClick: function () {
        var me = this,
            windowTitle, message, postUrl, successMsg;

        windowTitle = me.batchVerifyTitle;
        message = me.batchVerifyTip;
        postUrl = 'Api/ManualMaterialBill/BatchVerify';
        successMsg = me.batchVerifySuccess;

        me.buttonClickBatchPost(windowTitle, message, postUrl, successMsg);        
    },

    onReverifyClick: function () {
        var me = this,
            windowTitle, message, postUrl, successMsg;

        windowTitle = me.reverifyTitle;
        message = me.reverifyTip;
        postUrl = 'Api/ManualMaterialBill/Reverify';
        successMsg = me.reverifySuccess;
        me.buttonClickPost(windowTitle, message, postUrl, successMsg);
    },

    onTaskClick: function () {
        var me = this, windowTitle, message, postUrl, successMsg;

        windowTitle = me.taskTitle;
        message = me.taskTip;
        postUrl = 'Api/ManualMaterialBill/Task';
        successMsg = me.taskSuccess;
        me.buttonClickPost(windowTitle, message, postUrl, successMsg);
    },

    onBatchTaskClick: function () {
        var me = this, windowTitle, message, postUrl, successMsg;

        windowTitle = me.taskTitle;
        message = me.taskTip;
        postUrl = 'Api/ManualMaterialBill/BatchTask';
        successMsg = me.taskSuccess;
        me.buttonClickBatchPost(windowTitle, message, postUrl, successMsg);
    },

    onDetailAddClick: function (button) {

        var me = this, grid, selection, form, window;

        grid = me.getView();
        model = grid.getSelectionModel().getSelection()[0];
        selection = grid.getSelectionModel().getSelection();
        if (selection.length != 1) {
            Fusion.toast(me.duplicateTip + '!')
            return;
        };

        form = Ext.create('Fusion.warehouse.view.bill.ManualMaterialBills.ShiftManualMaterialBill');
        window = Fusion.window({
            title: me.shiftTitle,
            grid: grid,
            items: form,
            buttons: [{
                text: me.saveTitle,
                itemId: 'btnDetailAdd',
                iconCls: 'x-fa fa-save',
                disabled: false,
                handler: function () {
                    me.onCreateInfo(window, model);
                }
            }]
        });
        form.loadRecord(model);
        form.getForm().findField('Classes').setStore(me.getClassesStore());

        window.show();
    },

    onCreateInfo: function (window, model) {
        var me = this, grid, manualMaterialBillNo, planBeginTime, planEndTime;

        manualMaterialBillNo = model.data.ManualMaterialBillNo;
        planBeginTime = window.down('form').getForm().findField('PlanBeginTime').getValue();
        planEndTime = window.down('form').getForm().findField('PlanEndTime').getValue();

        Ext.Ajax.request({
            url: 'Api/ManualMaterialBill/DetailAdd',
            jsonData: {
                manualMaterialBillNo: manualMaterialBillNo,
                planBeginTime: planBeginTime,
                planEndTime: planEndTime
            },
            method: 'POST',
            async: true,
            timeout: 10000,
            success: function (response) {
                var result = Ext.decode(response.responseText);
                if (result.success) {
                    Fusion.toast(me.shiftSuccess);
                    window.close();
                    window.grid.store.reload();
                }
                else {
                    Fusion.Msg.error(result.msg);
                }
            }
        });
    },

    onSettleClick: function () {        
        var me = this, grid, store, model, selection, manualMaterialBillNo, mask;
        grid = me.getView();
        store = grid.getStore();
        model = grid.getSelectionModel();
        selection = model.getSelection();
        manualMaterialBillNo = selection[0].data.ManualMaterialBillNo;

        Ext.MessageBox.confirm(
            "结单", "确定要结单吗？结单后将无法操作！请谨慎操作！",
            function (button, text)
            {
                if (button == 'yes')
                {
                    mask = new Ext.LoadMask({
                        msg: '正在处理数据，请稍等......',
                        target: grid,
                        removeMask: true
                    });
                    mask.show();

                    Ext.Ajax.request({
                        url: 'Api/ManualMaterialBill/Settle',
                        params: {
                            manualMaterialBillNo: manualMaterialBillNo
                        },
                        method: 'Get',
                        async: false,
                        timeout: 300000,
                        success: function (response) {
                            var result = Ext.decode(response.responseText);
                            if (result.success) {
                                Fusion.toast(me.settleSuccess);
                                store.reload();
                            }
                            else {
                                Fusion.Msg.error(result.msg);
                            }
                        },
                        callback: function (opts, success, response) {
                            mask.destroy();
                        }
                    });
                }
            });

    },

    onBatchSettleClick: function () {
        var me = this,
            windowTitle, message, postUrl, successMsg;

        windowTitle = me.settleTitle;
        message = me.settleTip;
        postUrl = 'Api/ManualMaterialBill/BatchSettle';
        successMsg = me.settleSuccess;
        me.buttonClickBatchPost(windowTitle, message, postUrl, successMsg);
    },

    buttonClickPost: function (windowTitle, message, postUrl, successMsg) {
        var me = this,
            grid, store, model, record, rowCount, selection, manualMaterialBillNo;

        grid = me.getView();
        store = grid.getStore();
        model = grid.getSelectionModel();
        selection = model.getSelection();
        manualMaterialBillNo = selection[0].data.ManualMaterialBillNo;

        Ext.Msg.confirm(windowTitle, message, function (btn) {
            if (btn === 'yes') {
                Ext.Ajax.request({
                    url: postUrl,
                    params: { manualMaterialBillNo: manualMaterialBillNo },
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
                                        if (store.getAt(i).get("ManualMaterialBillNo") === manualMaterialBillNo) {
                                            record = store.getAt(i);
                                            model.select(record, true);
                                            return;
                                        }
                                    }
                                }
                            });
                        }
                    }
                });
            }
        });
    },

    buttonClickBatchPost: function (windowTitle, message, postUrl, successMsg) {
        var me = this,
            grid, store, model, record, selected, productonPlanNos = [];

        grid = me.getView();
        store = grid.getStore();
        selected = grid.getSelectionModel().getSelection();

        Ext.Array.each(selected, function (record) {
            productonPlanNos.push(record.id);
        });

        model = grid.getSelectionModel();
        Ext.Msg.confirm(windowTitle, message, function (btn) {
            if (btn === 'yes') {
                mask = new Ext.LoadMask({
                    msg: '正在处理数据，请稍等......',
                    target: grid,
                    removeMask: true
                });
                mask.show();

                Ext.Ajax.request({
                    url: postUrl,
                    jsonData: productonPlanNos,
                    method: 'POST',
                    async: true,
                    timeout: 300000,
                    success: function (response) {
                        var result = Ext.decode(response.responseText);
                        if (result.success) {
                            //model.clearSelections();
                            Fusion.toast(successMsg);
                            store.reload();
                            me.onSelectionChange(model, selected);
                            //如果不使用clearSelections()是选择了这两行，但是this.getView().manualMaterialBill.get("ManualMaterialBillStatus")得到的还是原先的值，如何同步更新呢？
                            //如果使用cleareSelections()，那么后面就只会选择一行了，如何设置选择两行？？？
                        }
                        else {
                            Fusion.Msg.error(result.msg);
                        }
                    },
                    callback: function (opts, success, response) {
                        mask.destroy();
                    }
                });
            }
        });
    },

    onClassesChange: function (combo, newValue, oldValue, eOpts) {
        var me = this,
            form, beginTimeField, endTimeField,
            beginDate, endDate, beginTime, endTime;

        form = combo.up('window').down('form').getForm();
        beginTimeField = form.findField('PlanBeginTime');
        endTimeField = form.findField('PlanEndTime');
        beginDate = Ext.util.Format.date(beginTimeField.getValue(), 'Y/m/d');
        endDate = Ext.util.Format.date(endTimeField.getValue(), 'Y/m/d');
        beginTime = newValue.split('--')[0];
        endTime = newValue.split('--')[1];

        beginTimeField.setValue(new Date(beginDate + ' ' + beginTime));
        endTimeField.setValue(new Date(endDate + ' ' + endTime));
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
    }
});