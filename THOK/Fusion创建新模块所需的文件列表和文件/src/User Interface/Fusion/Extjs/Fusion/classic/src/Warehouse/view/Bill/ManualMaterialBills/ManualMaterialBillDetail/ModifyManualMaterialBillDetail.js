/*
* 2018-06-05 Create by hongwanzhen
*/
Ext.define('Fusion.warehouse.view.bill.ManualMaterialBills.ManualMaterialBillDetail.ModifyManualMaterialBillDetail', {
    extend: 'Ext.form.Panel',

    teamLabel: '班组信息',
    machineLabel: '机组信息',
    brandLabel: '牌号信息',
    labelWidth: 65,

    controller: 'manualMaterialBillDetail',
    viewModel: 'main',
    layout: 'fit',
    border: false,
    bodyPadding: '0 5 0 5',

    initComponent: function () {
        var me = this;

        me.items = [{
            border: false,
            margin: '13 14 8 5',

            defaults: {
                xtype: 'textfield',
                labelAlign: 'right',
                labelWidth: me.labelWidth
            },

            items: [{
                fieldLabel: me.teamLabel,
                name: 'TeamName',
                editable: false,
                allowBlank: false,
                triggers: {
                    search: {
                        cls: 'x-form-search-trigger',
                        handler: 'onTeamSearchClick'
                    }
                }
            }, {
                name: 'TeamCode',
                xtype: 'hidden'
            }, {
                fieldLabel: me.brandLabel,
                name: 'BrandName',
                editable: false,
                allowBlank: false,
                triggers: {
                    search: {
                        cls: 'x-form-search-trigger',
                        handler: 'onBrandSearchClick'
                    }
                }
            }, {
                name: 'BrandCode',
                xtype: 'hidden'
            }, {
                fieldLabel: me.machineLabel,
                name: 'MachineName',
                editable: false,
                allowBlank: false,
                triggers: {
                    search: {
                        cls: 'x-form-search-trigger',
                        handler: 'onMachineSearchClick'
                    }
                }
            }, {
                name: 'MachineCode',
                xtype: 'hidden'
            }]
        }];

        me.callParent();
    }
});