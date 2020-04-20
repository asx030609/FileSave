:sqlplus system/admin123456COM	:如果出现错误只有DBA才能导入由其他DBA导出的文件，则需要使用sqlplus授权
:grant dba to C##FUSION;	
imp C##FUSION/admin123456COM@127.0.0.11/orcl file=C:\Users\DEVELOP\Desktop\Fusion_tagu.dmp tables=(DMT_TAGU)  IGNORE=Y log=C:\Users\DEVELOP\Desktop\Fusion_tagu.log	:如果有外键关联的字段，要先添加好那个字段数据，不然没意义。
pause