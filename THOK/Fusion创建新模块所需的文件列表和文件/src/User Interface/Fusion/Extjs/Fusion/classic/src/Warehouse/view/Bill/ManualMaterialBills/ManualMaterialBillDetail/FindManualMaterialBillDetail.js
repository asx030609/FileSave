/*
* 2018-06-05 Create by hongwanzhen
*/
Ext.define('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.FindManualMaterialBillDetail', {
    extend: 'Ext.form.Panel',

    teamCodeLabel: '班组编码',
    teamNameLabel: '班组',
    machineCodeLabel: '机组编码',
    machineNameLabel: '机组',
    brandCodeLabel: '牌号编码',
    brandNameLabel: '牌号',
    manualMaterialBillDetailStatusLabel: '状态',
    labelWidth: 105,

    controller: 'manualMaterialBillDetail',
    layout: 'fit',
    border: false,
    bodyPadding: '0 5 0 5',

    initComponent: function () {
        var me = this;

        me.items = [{
            border: false,
            layout: 'vbox',
            bodyPadding: '15 10 15 0',

            defaults: {
                xtype: 'textfield',
                labelAlign: 'right',
                labelWidth: me.labelWidth,
                padding: '0 0 5 0'
            },

            items: [{
                fieldLabel: me.teamCodeLabel,
                name: 'TeamCode',
                operator: 'Contains'
            }, {
                fieldLabel: me.teamNameLabel,
                name: 'TeamName',
                operator: 'Contains'
            }, {
                fieldLabel: me.machineCodeLabel,
                name: 'MachineCode',
                operator: 'Contains'
            }, {
                fieldLabel: me.machineNameLabel,
                name: 'MachineName',
                operator: 'Contains'
            }, {
                fieldLabel: me.brandCodeLabel,
                name: 'BrandCode',
                operator: 'Contains'
            }, {
                fieldLabel: me.brandNameLabel,
                name: 'BrandName',
                operator: 'Contains'
            }, {
                xtype: 'combobox',
                name: 'ManualMaterialBillDetailStatus',
                operator: '==',
                fieldLabel: me.manualMaterialBillDetailStatusLabel,
                anyMatch: true,
                forceSelection: true,
                queryMode: 'local',
                displayField: 'Name',
                valueField: 'Value',
                store: 'manualMaterialBillDetailStatusStore',
                listeners: {
                    change: 'onComboChange'
                },
                triggers: {
                    clear: {
                        cls: 'x-form-clear-trigger',
                        handler: 'onComboClearTriggerClick',
                        hidden: true
                    }
                }
            }]
        }]

        me.callParent();
    }
});