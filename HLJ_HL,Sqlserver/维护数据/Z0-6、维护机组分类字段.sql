
UPDATE WM_Machine SET MachineClassify='01#机组' WHERE MachineCode IN ('B101','J101');
UPDATE WM_Machine SET MachineClassify='02#机组' WHERE MachineCode IN ('B102','J102');
UPDATE WM_Machine SET MachineClassify='03#机组' WHERE MachineCode IN ('B103','J103');
UPDATE WM_Machine SET MachineClassify='04#机组' WHERE MachineCode IN ('B104','J104');
UPDATE WM_Machine SET MachineClassify='05#机组' WHERE MachineCode IN ('B105','J105');
UPDATE WM_Machine SET MachineClassify='06#机组' WHERE MachineCode IN ('B106','J106');
UPDATE WM_Machine SET MachineClassify='07#机组' WHERE MachineCode IN ('B107','J107');
UPDATE WM_Machine SET MachineClassify='08#机组' WHERE MachineCode IN ('B108','J108');
UPDATE WM_Machine SET MachineClassify='09#机组' WHERE MachineCode IN ('B109','J109');
UPDATE WM_Machine SET MachineClassify='10#机组' WHERE MachineCode IN ('B110','J110');
UPDATE WM_Machine SET MachineClassify='11#机组' WHERE MachineCode IN ('B111','J111');
UPDATE WM_Machine SET MachineClassify='12#机组' WHERE MachineCode IN ('B112','J112');
UPDATE WM_Machine SET MachineClassify='13#机组' WHERE MachineCode IN ('B113','J113');

SELECT * FROM WM_Machine WHERE MachineCode IN ('B101','J101');




SELECT * FROM WM_Machine where MachineCode in ('B101','B102','B103','B104','B105','B106','J101','J102','J103','J104','J105','J106');