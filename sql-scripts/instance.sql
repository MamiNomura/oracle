set echo off

prompt
prompt instance name must be STDBYGA1 for test1 environment
prompt
select instance_name, host_name, startup_time from v$instance;

prompt
prompt session count should be less that 50 for test1 environment
prompt
select count(*) from v$session;

set echo on

