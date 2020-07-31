/*
* 
*/
Ext.define('Fusion.warehouse.view.bill.ManualMaterialBills.ModifyManualMaterialBill', {
    extend: 'Ext.form.Panel',

    manualMaterialBillNoLabel: '计划单号',
    manualMaterialBillNoValidate: '计划单号已存在！',
    classesLabel: '班次',
    planBeginTimeLabel: '计划开始时间',
    planEndTimeLabel: '计划结束时间',
    regexCodeValidate: '只能输入大小写字母、数字、下划线、横线',

    controller: 'manualMaterialBill',
    layout: 'fit',
    border: false,
    bodyPadding: '0 5 0 5',
    labelWidth: 85,

    initComponent: function () {
        var me = this;

        me.items = [{
            border: false,
            layout: 'vbox',
            bodyPadding: '15 10 15 0',

            defaults: {
                xtype: 'textfield',
                labelAlign: 'right',
                labelWidth: me.labelWidth
            },

            items: [{
                fieldLabel: me.manualMaterialBillNoLabel,
                name: 'ManualMaterialBillNo',
                regex: /^[a-zA-Z0-9_-]*$/,
                regexText: me.regexCodeValidate
            }, {
                xtype: 'combobox',
                fieldLabel: me.classesLabel,
                name: 'Classes',
                tpl: Ext.create('Ext.XTemplate',
                    '<ul class="x-list-plain"><tpl for=".">',
                    '<li role="option" class="x-boundlist-item">{key} {value}</li>',
                    '</tpl></ul>'
                ),
                displayTpl: Ext.create('Ext.XTemplate',
                    '<tpl for=".">',
                    '{key} {value}',
                    '</tpl>'
                ),
                valueField: 'value',
                listeners: {
                    change: 'onClassesChange'
                }
            }, {
                xtype: 'datetimefield',
                fieldLabel: me.planBeginTimeLabel,
                name: 'PlanBeginTime',
                format: 'Y/m/d H:i:s',
                editable: false,
                allowBlank: false,
                value: Ext.util.Format.date(Ext.Date.add(new Date()), "Y/m/d 00:00:00"),
                triggers: {
                    clear: {
                        cls: 'x-form-clear-trigger',
                        handler: 'onComboClearTriggerClick',
                        hidden: true
                    }
                }
            }, {
                xtype: 'datetimefield',
                fieldLabel: me.planEndTimeLabel,
                name: 'PlanEndTime',
                format: 'Y/m/d H:i:s',
                editable: false,
                allowBlank: false,
                value: Ext.util.Format.date(Ext.Date.add(new Date()), "Y/m/d 23:59:59"),
                triggers: {
                    clear: {
                        cls: 'x-form-clear-trigger',
                        handler: 'onComboClearTriggerClick',
                        hidden: true
                    }
                }
            }]
        }];

        me.callParent();
    }
});