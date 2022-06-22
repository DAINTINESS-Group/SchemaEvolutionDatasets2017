CREATE DATABASE IF NOT EXISTS pypro_db;
USE pypro_db;
create user 'pypro'@'localhost' identified by 'omg-change-this-pw';
grant all privileges on pypro_db.* to 'pypro'@'localhost';

#and below are the sql statements to create the database

alter table io_sys drop foreign key fk_is_session_id;
alter table mem_proc drop foreign key fk_mp_proc_id;
alter table mem_proc drop foreign key fk_mp_session_id;
alter table mem_sys drop foreign key fk_ms_session_id;
alter table cpu_proc drop foreign key fk_cp_session_id;
alter table cpu_proc drop foreign key fk_cp_proc_id;
alter table cpu_sys drop foreign key fk_cs_session_id;
alter table event_log drop foreign key fk_el_session_id;
alter table event_log drop foreign key fk_el_proc_id;
alter table event_log drop foreign key fk_el_event_type_id;
alter table proc_info drop foreign key fk_pi_session_id;

DROP TABLE IF EXISTS proc_info;
DROP TABLE IF EXISTS event_type;
DROP TABLE IF EXISTS event_log;
DROP TABLE IF EXISTS cpu_sys;
DROP TABLE IF EXISTS cpu_proc;
DROP TABLE IF EXISTS mem_sys;
DROP TABLE IF EXISTS mem_proc;
DROP TABLE IF EXISTS io_sys;
DROP TABLE IF EXISTS session_info;

CREATE TABLE session_info (
  session_id int(5),
  description varchar(255),
  PRIMARY KEY (session_id),
  INDEX ind_si_sid (session_id)
  ) ENGINE=InnoDB;

CREATE TABLE proc_info (
  session_id int(5),
  rec_time datetime NOT NULL,
  proc_id int(5),
  name varchar(255),
  INDEX ind_proc (proc_id),
  CONSTRAINT fk_pi_session_id FOREIGN KEY (session_id) REFERENCES session_info (session_id)
  ) ENGINE=InnoDB;

CREATE TABLE event_type (
  type_id int(3) NOT NULL auto_increment,
  description varchar(255),
  PRIMARY KEY (type_id)
  ) ENGINE=InnoDB;

CREATE TABLE event_log (
  session_id int(5),
  event_id bigint(20) NOT NULL auto_increment,
  proc_id int(5),
  event_time datetime,
  event_type int(3),
  PRIMARY KEY (event_id),
  CONSTRAINT fk_el_session_id FOREIGN KEY (session_id) REFERENCES session_info (session_id),
  CONSTRAINT fk_el_proc_id FOREIGN KEY (proc_id) REFERENCES proc_info (proc_id),
  CONSTRAINT fk_el_event_type_id FOREIGN KEY (event_type) REFERENCES event_type(type_id),
  INDEX ind_el_sid (session_id)
  ) ENGINE=InnoDB;

CREATE TABLE cpu_sys (
  session_id int(5),
  rec_time datetime,
  #allow for 10 digits in seconds and 2 in fractions. 10 digits is some 300+ years
  user_mode decimal(12,2) NOT NULL,
  kernel_mode decimal(12,2) NOT NULL,
  idle_mode decimal(12,2) NOT NULL,
  percent decimal(5,2) NOT NULL,
  CONSTRAINT fk_cs_session_id FOREIGN KEY (session_id) REFERENCES session_info (session_id),
  INDEX ind_cs_sid (session_id)
  ) ENGINE=InnoDB;

CREATE TABLE cpu_proc (
  session_id int(5),
  rec_time datetime,
  proc_id int(5),
  priority int(5),
  ctx_switches int(5),
  threads int(5),
  user_mode decimal(12,2) NOT NULL,
  kernel_mode decimal(12,2) NOT NULL,
  CONSTRAINT fk_cp_proc_id FOREIGN KEY (proc_id) REFERENCES proc_info (proc_id),
  CONSTRAINT fk_cp_session_id FOREIGN KEY (session_id) REFERENCES session_info (session_id),
  INDEX ind_cp_sid (session_id)
  ) ENGINE=InnoDB;

CREATE TABLE mem_sys (
  session_id int(5),
  rec_time datetime,
  available bigint(15) NOT NULL,
  percent decimal(5,2) NOT NULL,
  used bigint(15) NOT NULL,
  free bigint(15) NOT NULL,
  swap_total bigint(15) NOT NULL,
  swap_free bigint(15) NOT NULL,
  swap_in bigint(15) NOT NULL,
  swap_out bigint(15) NOT NULL,
  swap_percent decimal(5,2) NOT NULL,
  CONSTRAINT fk_ms_session_id FOREIGN KEY (session_id) REFERENCES session_info (session_id),
  INDEX ind_ms_sid (session_id)
  ) ENGINE=InnoDB;

CREATE TABLE mem_proc (
  session_id int(5),
  rec_time datetime,
  proc_id int(5),
  used bigint(15),
  virtual bigint(15),
  percent decimal(5,2) NOT NULL,
  CONSTRAINT fk_mp_proc_id FOREIGN KEY (proc_id) REFERENCES proc_info (proc_id),
  CONSTRAINT fk_mp_session_id FOREIGN KEY (session_id) REFERENCES session_info (session_id),
  INDEX ind_mp_sid (session_id)
  ) ENGINE=InnoDB;

CREATE TABLE io_sys (
  session_id int(5),
  rec_time datetime,
  bytes_sent bigint(15) NOT NULL,
  bytes_received bigint(15) NOT NULL,
  packets_sent bigint(15) NOT NULL,
  packets_received bigint(15) NOT NULL,
  errors_in int(5) NOT NULL,
  errors_out int(5) NOT NULL,
  dropped_in int(5) NOT NULL,
  dropped_out int(5) NOT NULL,
  CONSTRAINT fk_is_session_id FOREIGN KEY (session_id) REFERENCES session_info (session_id),
  INDEX ind_is_sid (session_id)
  ) ENGINE=InnoDB;


