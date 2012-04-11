select job, what, broken, failures, next_date, next_sec from user_jobs where broken = 'Y' or failures > 0;
