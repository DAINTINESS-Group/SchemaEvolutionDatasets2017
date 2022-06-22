CREATE TABLE job(	     id INTEGER PRIMARY KEY ,
	     description TEXT NOT NULL,
	     user_name TEXT NOT NULL,
	     calculation_mode TEXT NOT NULL,
	     hazard_calculation_id INTEGER ,
	     status TEXT NOT NULL ,
	     is_running BOOL NOT NULL ,
	     start_time TIMESTAMP NOT NULL ,
	     stop_time TIMESTAMP,
	     relevant BOOL,
	     ds_calc_dir TEXT NOT NULL);

CREATE TABLE log(	     id INTEGER PRIMARY KEY ,
	     job_id INTEGER NOT NULL ,
	     timestamp TIMESTAMP NOT NULL,
	     level TEXT NOT NULL,
	     process TEXT NOT NULL,
	     message TEXT NOT NULL);

CREATE TABLE output(	     id INTEGER PRIMARY KEY ,
     	     oq_job_id INTEGER NOT NULL ,
	     display_name TEXT NOT NULL,
	     last_update TIMESTAMP NOT NULL ,
	     ds_key TEXT NOT NULL);

CREATE TABLE performance(	     id INTEGER PRIMARY KEY ,
	     job_id INTEGER NOT NULL ,
	     operation TEXT NOT NULL,
	     time_sec FLOAT NOT NULL,
	     memory_mb FLOAT NOT NULL,
	     counts INTEGER NOT NULL);

