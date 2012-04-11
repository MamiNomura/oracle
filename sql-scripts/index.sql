column table_name format a15 word_wrapped
column index_name format a25 word_wrapped
column columns format a40

break on table_name skip 1

select table_name,
     index_name,
rtrim(
     max( decode( column_position, 1, column_name, '' ) )||','||
     max( decode( column_position, 2, column_name, '' ) )||','||
     max( decode( column_position, 3, column_name, '' ) )||','||
     max( decode( column_position, 4, column_name, '' ) )||','||
     max( decode( column_position, 5, column_name, '' ) )||','||
     max( decode( column_position, 6, column_name, '' ) )||','||
     max( decode( column_position, 7, column_name, '' ) )||','||
     max( decode( column_position, 8, column_name, '' ) )||','||
     max( decode( column_position, 9, column_name, '' ) )||','||
     max( decode( column_position, 10, column_name, '' ) )||','||
     max( decode( column_position, 11, column_name, '' ) )||','||
     max( decode( column_position, 12, column_name, '' ) )||','||
     max( decode( column_position, 13, column_name, '' ) )||','||
     max( decode( column_position, 14, column_name, '' ) )||','||
     max( decode( column_position, 15, column_name, '' ) )||','||
     max( decode( column_position, 16, column_name, '' ) ), ',' )
     columns
from user_ind_columns
group by table_name,index_name
/
