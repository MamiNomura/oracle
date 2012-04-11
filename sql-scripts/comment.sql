-- desc.sql
--
-- a substitute for the describe command (which uses too much horizontal space when my linesize is large)

set autotrace off

set echo off
set verify off
set timing off
set feedback off
set recsep off

column column_name format a30   heading "Column Name"
column nullable    format a8    heading "Nullable"
column data_type   format a10   heading "Data Type"
column len         format 99999 heading "Length"
column column_comment format a35 word_wrapped heading "Comment"

column table_comment format a70 word_wrapped

set heading off

select 'Table Name: ' || upper('&1') from dual;

select  nvl(comments, 'No comments on table &1') as table_comment
from	user_tab_comments
where	table_name = upper('&1');

set heading on

select	lower(cols.column_name) as column_name, 
	lower(cols.data_type) as data_type, 
	cols.data_length as len, 
	decode(cols.nullable, 'N', 'NOT NULL', '') as nullable,
	ucc.comments as column_comment
from	cols,
	user_col_comments ucc
where	cols.table_name = upper('&1')
and	cols.table_name = ucc.table_name
and	cols.column_name = ucc.column_name
order   by column_id;

set heading off
select null from dual;
set heading on

set timing on
set feedback on
