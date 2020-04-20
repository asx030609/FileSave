declare

TYPE locationType IS RECORD
(locationCode WM_LOCATIONU.LOCATION_CODEU%TYPE);

TYPE locations IS Table of locationType;

locationTable locations;

palletNumber number:= 25;

palletIndex number;

begin
  
  select distinct location_codeu bulk collect into locationTable from  WM_LOCATIONU;

  for i in locationTable.first..locationTable.last loop
      delete from WM_PALLETU p where p.location_codeu = locationTable(i).locationCode;
  
      palletIndex :=0;
      
      loop 
        
      insert into WM_PALLETU (idu,location_codeu,pallet_nameu,product_countu,storage_quantityu,in_frozen_quantityu,out_frozen_quantityu,storage_sequenceu,pallet_nou,inbound_position_nou,outbound_position_nou,create_timeu,update_timeu,row_versionu)
      values(sys_guid(),locationTable(i).locationCode,'елн╩',0,0,0,0,0,0,0,0,sysdate,sysdate,sys_guid());
      
      palletIndex:= palletIndex+1;
      
      exit when palletIndex = 25;
       
      end loop;        
      
  end loop;

end;
