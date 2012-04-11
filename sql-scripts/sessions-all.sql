SELECT s.sid,
       s.serial#,
       s.osuser,
       s.program
FROM   v$session s;
