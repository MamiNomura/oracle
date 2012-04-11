set verify off
set linesize 172
set pagesize 9999
set feedback off
variable owner varchar2(30)
variable tname varchar2(30)
begin
  :owner := USER;
  :tname := upper('&1');
end;
/
Prompt Datatypes for Table &1
column data_type format a20
column column_name heading "Column Name"
column data_type   heading "Data|Type"
column data_length heading "Data|Length"
column nullable    heading "Nullable"
select column_name,
       data_type,
       substr(
       decode( data_type, 'NUMBER',
               decode( data_precision, NULL, NULL,
                '('||data_precision||','||data_scale||')' ),
           data_length),
              1,11) data_length,
       decode( nullable, 'Y', 'null', 'not null' ) nullable
from all_tab_columns
where owner = :owner
  and table_name = :tname
order by column_id
/
prompt
prompt
Prompt Indexes on &1
column index_name heading "Index|Name"
column Uniqueness heading "Is|Unique" format a6
column columns format a32 word_wrapped

select substr(a.index_name,1,30) index_name,
     decode(a.uniqueness,'UNIQUE','Yes','No') uniqueness,
max(decode( b.column_position,  1, substr(b.column_name,1,30),
NULL )) ||
max(decode( b.column_position,  2, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position,  3, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position,  4, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position,  5, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position,  6, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position,  7, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position,  8, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position,  9, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 10, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 11, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 12, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 13, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 14, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 15, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 16, ', '||
substr(b.column_name,1,30), NULL )) columns
from all_indexes a, all_ind_columns b
where a.owner = :owner
and a.table_name = :tname
and b.table_name = a.table_name
and b.table_owner = a.owner
and a.index_name = b.index_name
group by substr(a.index_name,1,30), a.uniqueness
/
prompt
prompt
prompt Triggers on &1
set long 5000
select trigger_name, trigger_type,
     triggering_event, trigger_body
from user_triggers where table_name = :tname
/
