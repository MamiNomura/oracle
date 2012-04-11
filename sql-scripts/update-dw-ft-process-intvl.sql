-- author: Mami Nomura
-- date: 2006-02-07
-- purpose: 
-- if your schema has not been running for processing financial datawareshouse
-- then running this script will make your schema up-to-date. 
--

declare
 v_start_date_hour date;
 jnum integer;
begin
  select max(start_date_hour) into v_start_date_hour
  from dw_ft_process_interval;

  for e in (
  select count(*) as cnt,
         trunc(audit_date,'HH24') as process_date
  from   dw_finance_log
  where  audit_date > v_start_date_hour
  group by trunc(audit_date,'HH24')
  having count(*) > 0
  ) loop
    dw_finance.dw_finance_do_everything(e.process_date);
  end loop;

  begin
  insert into dw_ft_process_interval
  (start_date_hour, end_date_hour)
  values
  (trunc(sysdate-2/24, 'HH24'), trunc(sysdate-1/24, 'HH24'));
  exception when DUP_VAL_ON_INDEX then
   null;
  end;
  commit;

  -- now update job
  select job into jnum
  from user_jobs where what = 'dw_finance.dw_finance_do_everything(NULL);';

  dbms_job.run(jnum);

end;
/
show errors
