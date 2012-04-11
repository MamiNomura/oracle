select object_name, object_type, status from user_objects where status <> 'VALID'
union
select index_name, 'index: ' || index_type, status from user_indexes where status not in ('VALID','N/A')
;

