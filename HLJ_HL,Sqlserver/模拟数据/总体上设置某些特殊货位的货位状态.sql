



--»õÎ»×´Ì¬ÊÇDisable=0,Normal=1,BanOut=2,BanIn=3,Freeze=4,Hand=5
update WM_Location SET LocationStatus=1;

SELECT * FROM WM_Location WHERE LocationCode like '01-%' or LocationCode like '02-%';