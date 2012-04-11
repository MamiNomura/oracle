-- kill-session.sql
--
-- Kills a session
--
-- usage: @ kill-session sid serial
--

alter system kill session '&1,&2';
