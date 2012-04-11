select SID from v$session where AUDSID = userenv('SESSIONID');
