set long 100000
select pa_type, sql_string
from   qb_query q, personal_attribute_query p, ga_sheets
where  query_id = one_member_query_id
and    pa_type_id = sheet_id
and    dd_page_id = '&1';

