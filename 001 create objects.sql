--drop table vz_114819_holiday;
create table vz_114819_holiday
(
    dat        date,
    descr      varchar2(32),
    date_type  char(1)           -- R (red) - праздничный день, B (black) рабочие суббота или воскресенье, T ( transfer ) - праздничный день переносится на работий 
);

insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('01.01.2020', 'dd.mm.yyyy'), 'Новый Год', 'R');
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('02.01.2020', 'dd.mm.yyyy'), 'Новый Год', 'R');
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('03.01.2020', 'dd.mm.yyyy'), 'Новый Год', 'R');
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('04.01.2020', 'dd.mm.yyyy'), 'Новый Год', 'R');
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('05.01.2020', 'dd.mm.yyyy'), 'Новый Год', 'R');
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('06.01.2020', 'dd.mm.yyyy'), 'Новый Год', 'R');
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('07.01.2020', 'dd.mm.yyyy'), 'Рождество', 'R');
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('08.01.2020', 'dd.mm.yyyy'), 'Новый Год', 'R');

insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('23.02.2020', 'dd.mm.yyyy'), 'День защитника Отечества', 'R');
-- перенос
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('24.02.2020', 'dd.mm.yyyy'), '', 'T');
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('08.03.2020', 'dd.mm.yyyy'), 'Международный женский день', 'R');
-- перенос
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('09.03.2020', 'dd.mm.yyyy'), '', 'T');

insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('01.05.2020', 'dd.mm.yyyy'), 'Праздник весны и труда', 'R');
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('09.05.2020', 'dd.mm.yyyy'), 'День Победы', 'R');
-- перенос
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('10.05.2020', 'dd.mm.yyyy'), '', 'T');

insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('12.06.2020', 'dd.mm.yyyy'), 'День России', 'R');
insert into vz_114819_holiday ( dat, descr, date_type) values ( to_date('04.11.2020', 'dd.mm.yyyy'), 'День народного единства', 'R');

commit;

select * from vz_114819_holiday tbl;

-------------------------------  Заполним календарь ------------------------------

create table vz_114819_calendar as
select curr_date as DAY_ID
     , to_char(curr_date,'DY') as WK_DAY_NM_SHT
     , to_char(curr_date,'Day') as WK_DAY_NM_LN
     , to_number(trim(leading '0' from to_char(curr_date,'D'))) as WK_DAY_NUM
     , to_number(trim(leading '0' from to_char(curr_date,'DD'))) as DAY_NUM_OF_MON
     , to_number(trim(leading '0' from to_char(curr_date,'DDD'))) as DAY_NUM_OF_YR
  from
 (
     select level n
       -- Календарь формируется начиная со следующей после указанной даты.
          , to_date('31.12.2010','DD.MM.YYYY') + numtodsinterval(level,'day') curr_date
       from dual
       -- Количество дней в календаре => сделаем до конца текущего года
     connect by level <= to_date('31.12.2020', 'dd.mm.yyyy') - to_date('31.12.2010', 'dd.mm.yyyy'))
       order by curr_date;

select *
  from vz_114819_calendar cl
 where 1 = 1;
   
