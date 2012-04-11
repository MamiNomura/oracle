set echo off

prompt ga_dw.make_new_process_interval;
execute ga_dw.make_new_process_interval;
select ga_dw.get_process_interval_min from dual;

prompt ga_dw.mf_do_everything(NULL);
execute ga_dw.mf_do_everything(NULL);

prompt ga_dw.off_do_everything(NULL);
execute ga_dw.off_do_everything(NULL);

prompt ga_dw.ml_do_everything(NULL);
execute ga_dw.ml_do_everything(NULL);

prompt ga_dw.tcl_do_everything(NULL);
execute ga_dw.tcl_do_everything(NULL);

prompt ga_dw.pv_do_everything(NULL);
execute ga_dw.pv_do_everything(NULL);

prompt done.

