#!/bin/bash

# for every arg on the command line, make a load-filename.sql

for filename in $*
do
  basename="${filename%%.sql}"
  ld_name="load-$filename"

  if [ -f $ld_name ]; then
      echo "file exists: $ld_name"
      echo "Do \"rm load-*.sql\" first (but only if you should)."
      exit 1
  fi
      
  echo "whenever oserror exit failure rollback" >> $ld_name
  echo "whenever sqlerror exit failure rollback" >> $ld_name
  echo "" >> $ld_name
  echo "column set_log_date  new_value log_date" >> $ld_name
  echo "select to_char(sysdate, 'YYYYMMDD.HH24MISS') as set_log_date" >> $ld_name
  echo "from dual;" >> $ld_name
  echo "" >> $ld_name
  echo "set echo on" >> $ld_name
  echo "set time on" >> $ld_name
  echo "set timing on" >> $ld_name
  echo "set feedback on" >> $ld_name
  echo "spool ${basename}-&log_date..log" >> $ld_name
  echo "" >> $ld_name
  echo "@@ $filename" >> $ld_name
  echo "" >> $ld_name
  echo "spool off" >> $ld_name
  echo "set echo off" >> $ld_name
  echo "whenever oserror continue none" >> $ld_name
  echo "whenever sqlerror continue none" >> $ld_name


done

