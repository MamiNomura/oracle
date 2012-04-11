-- compares run date of dw to the date-based excerpt that was processed.
-- For example, here are some normal results:
--
-- none yet!
--
select to_char(entry_time,'YYYY-MM-DD HH24:MI:SS') as run_date,
       object_name as date_excerpt,
--       member_name,
       decode( PHASE_NAME,
               'new start date',
              24 * (entry_time - to_date(object_name,'YYYY-MM-DD HH24:MI:SS')),
              null) as delta_hours
from nl_dw_process_log
where
   ( (MEMBER_NAME = 'make_new_process_interval' and PHASE_NAME = 'new start date')
     or
     (MEMBER_NAME = 'do_everything' and PHASE_NAME = 'complete')
   )
and entry_time > sysdate -30
order by entry_time
;
