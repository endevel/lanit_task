/**
 * \descr Вычисляет кол-во рабочих дней между двумя датами
 * \param pi_beg_dt - начальная дата периода
 * \param pi_end_dt - конечная дата диапазонв
 * \result - кол-во рабочих дней между pi_beg_dt и pi_end_dt
 * \created 2020-02-13
 * \author ...
 */
create or replace function vz_114819_calculate_bus_days ( pi_beg_dt in date, pi_end_dt in date )
  return number is

  l_beg_dt    date;
  l_end_dt    date;
  l_cnt       number;
  l_res       number;
begin
  l_res := 0;  
  if pi_beg_dt > pi_end_dt then
    l_beg_dt := trunc(pi_end_dt);
    l_end_dt := trunc(pi_beg_dt);
  else
    l_beg_dt := trunc(pi_beg_dt);
    l_end_dt := trunc(pi_end_dt);
  end if;

  -- Количество рабочих дней, попадающих в заданный период  (с) Tom Kyte
  select count(*)
    into l_cnt
    from (
        select mod(to_char(l_beg_dt + tbl.rn, 'J'), 7) + 1 dy
          from (
              select rownum - 1 as rn
                from vz_114819_calendar  -- вот для этого создавали календарь, Tom Kyte использовал all_objects, т.е. можно без доп. таблицы 
               where 1 = 1
                 and rownum <= ( select trunc(l_end_dt) - trunc(l_beg_dt) + 1 from dual )
          ) tbl
    ) d
   where d.dy not in ( 6, 7 );
   l_res := l_res + l_cnt;

  -- Посчитаем праздничные дни, попадающие в заданный период
  with tbl as (
  select tmp.dat
      , mod(to_char(tmp.dat, 'J'), 7) + 1 as dy
    from vz_114819_holiday tmp
   where 1 = 1
     and tmp.date_type in ( 'R', 'T' )
     and tmp.dat >= l_beg_dt
     and tmp.dat <= l_end_dt
  )
  select count(*)
    into l_cnt
    from tbl
   where 1 = 1     
     and dy not in ( 6, 7);  -- выходные уже вычли на первом шаге

   -- праздники вычитаем
   l_res := l_res - l_cnt;

  -- Посчитаем выходные, ставшие из-за переносов рабочими
  select count(*)
    into l_cnt
    from vz_114819_holiday tmp
   where 1 = 1
     and tmp.date_type = ( 'B' )
     and tmp.dat >= l_beg_dt
     and tmp.dat <= l_end_dt;

   -- добавляем ..
   l_res := l_res + l_cnt;

   return l_res;
end;
/
