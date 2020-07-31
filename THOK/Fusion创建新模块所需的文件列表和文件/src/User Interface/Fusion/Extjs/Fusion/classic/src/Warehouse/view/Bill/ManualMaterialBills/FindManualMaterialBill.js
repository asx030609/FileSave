/*
* 2018-06-05 Create by hongwanzhen
*/
Ext.define('Fusion.warehouse.view.bill.ManualMaterialBills.FindManualMaterialBill', {
    extend: 'Ext.form.Panel',

    labelWidth: 95,
    manualMaterialBillNoLabel: '计划单号',
    manualMaterialBillStatusLabel: '单据状态',
    planBeginTimeLabel: '计划开始时间从',
    makerLabel: '制单人员',
    auditorLabel: '审核人员',
    makeTimeLabel: '制单时间从',
    toLabel: '至',
    manualMaterialBillOriginLabel: '计划来源',

    controller: 'manualMaterialBill',
    layout: 'fit',
    border: false,
    bodyPadding: 5,

    initComponent: function () {
        var me = this;

        me.items = [{
            xtype: 'container',
            layout: 'vbox',
            margin: '13 14 8 0',

            defaults: {
                layout: 'hbox',
                border: false,

                defaults: {
                    xtype: 'textfield',
                    labelAlign: 'right',
                    labelWidth: me.labelWidth,
                    padding: '0 0 5 10'
                }
            },

            items: [{
                items: [{
                    fieldLabel: me.manualMaterialBillNoLabel,
                    name: 'ManualMaterialBillNo',
                    operator: 'Contains'
                }, {
                    xtype: 'combobox',
                    name: 'ManualMaterialBillStatus',
                    operator: '==',
                    fieldLabel: me.manualMaterialBillStatusLabel,
                    anyMatch: true,
                    forceSelection: true,
                    queryMode: 'local',
                    displayField: 'Name',
                    valueField: 'Value',
                    store: 'manualMaterialBillStatusStore',
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
            }, {
                items: [{
                    xtype: 'datefield',
                    fieldLabel: me.planBeginTimeLabel,
                    name: 'PlanBeginTime',
                    format: 'Y/m/d',
                    editable: false,
                    listeners: {
                        change: 'onComboChange'
                    },
                    triggers: {
                        clear: {
                            cls: 'x-form-clear-trigger',
                            handler: 'onComboClearTriggerClick',
                            hidden: true
                        }
                    },
                    operator: '>='
                }, {
                    xtype: 'datefield',
                    fieldLabel: me.toLabel,
                    name: 'PlanBeginTime',
                    format: 'Y/m/d',
                    editable: false,
                    listeners: {
                        change: 'onComboChange'
                    },
                    triggers: {
                        clear: {
                            cls: 'x-form-clear-trigger',
                            handler: 'onComboClearTriggerClick',
                            hidden: true
                        }
                    },
                    operator: '<='
                }]
            }, {
                items: [{
                    fieldLabel: me.makerLabel,
                    name: 'Maker',
                    operator: 'Contains'
                }, {
                    fieldLabel: me.auditorLabel,
                    name: 'Auditor',
                    operator: 'Contains'
                }]
            }, {
                items: [{
                    xtype: 'datefield',
                    fieldLabel: me.makeTimeLabel,
                    name: 'MakeTime',
                    format: 'Y/m/d',
                    editable: false,
                    listeners: {
                        change: 'onComboChange'
                    },
                    triggers: {
                        clear: {
                            cls: 'x-form-clear-trigger',
                            handler: 'onComboClearTriggerClick',
                            hidden: true
                        }
                    },
                    operator: '>='
                }, {
                    xtype: 'datefield',
                    fieldLabel: me.toLabel,
                    name: 'MakeTime',
                    format: 'Y/m/d',
                    editable: false,
                    listeners: {
                        change: 'onComboChange'
                    },
                    triggers: {
                        clear: {
                            cls: 'x-form-clear-trigger',
                            handler: 'onComboClearTriggerClick',
                            hidden: true
                        }
                    },
                    operator: '<='
                }]
            }, {
                items: [{
                    xtype: 'combobox',
                    name: 'ManualMaterialBillOrigin',
                    operator: '==',
                    fieldLabel: me.manualMaterialBillOriginLabel,
                    anyMatch: true,
                    forceSelection: true,
                    queryMode: 'local',
                    displayField: 'Name',
                    valueField: 'Value',
                    store: 'manualMaterialBillOriginStore',
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
        }];

        me.callParent();
    }
});