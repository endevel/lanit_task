declare
  l_cnt number;
begin
  l_cnt := vz_114819_calculate_bus_days(to_date('01.01.2020', 'dd.mm.yyyy'), to_date('31.01.2020', 'dd.mm.yyyy'));  
  DBMS_OUTPUT.put_line( '01. ' || case when l_cnt = 17 then 'Ok' else '!!! ERROR !!!' end );
  
  l_cnt := vz_114819_calculate_bus_days(to_date('01.02.2020', 'dd.mm.yyyy'), to_date('28.02.2020', 'dd.mm.yyyy'));  
  DBMS_OUTPUT.put_line( '02. ' || case when l_cnt = 19 then 'Ok' else '!!! ERROR !!!' end );

  l_cnt := vz_114819_calculate_bus_days(to_date('01.03.2020', 'dd.mm.yyyy'), to_date('31.03.2020', 'dd.mm.yyyy'));  
  DBMS_OUTPUT.put_line( '03. ' || case when l_cnt = 21 then 'Ok' else '!!! ERROR !!!' end );

  l_cnt := vz_114819_calculate_bus_days(to_date('01.04.2020', 'dd.mm.yyyy'), to_date('30.04.2020', 'dd.mm.yyyy'));  
  DBMS_OUTPUT.put_line( '04. ' || case when l_cnt = 22 then 'Ok' else '!!! ERROR !!!' end );
  
  -- .. --
  
  l_cnt := vz_114819_calculate_bus_days(to_date('01.12.2020', 'dd.mm.yyyy'), to_date('31.12.2020', 'dd.mm.yyyy'));  
  DBMS_OUTPUT.put_line( '12. ' || case when l_cnt = 23 then 'Ok' else '!!! ERROR !!!' end );

  ----------------------------------------
  -- bad test ----------------------------
  ----------------------------------------  
  DBMS_OUTPUT.put_line(' ');    
  DBMS_OUTPUT.put_line(' ');      
  l_cnt := vz_114819_calculate_bus_days(to_date('01.06.2020', 'dd.mm.yyyy'), to_date('30.06.2020', 'dd.mm.yyyy'));  
  DBMS_OUTPUT.put_line( ' ---- bad test start ---- ' );  
  -- Не учли, 12.06 ( праздник )  
  DBMS_OUTPUT.put_line( '06. ' || case when l_cnt = 22 then 'Ok' else '!!! ERROR !!!' end );  
  DBMS_OUTPUT.put_line( ' ---- bad test finish ---- ' );    
  
  DBMS_OUTPUT.put_line(' ');    
  DBMS_OUTPUT.put_line(' ');    
  l_cnt := vz_114819_calculate_bus_days(to_date('01.06.2020', 'dd.mm.yyyy'), to_date('30.06.2020', 'dd.mm.yyyy'));  
  -- Теперь учли
  DBMS_OUTPUT.put_line( '06. ' || case when l_cnt = 21 then 'Ok' else '!!! ERROR !!!' end );  
  
end;
