-- $Id: combined_schema.sql,v 1.80 2008/12/19 13:38:07 pbell Exp $
-- $Revision: 1.80 $
---------------------------------------------------------
-- SQL script for the schema generation of the TriggerDB
--
-- This script simply combines scripts that have been
-- developed before (see comments below)
-- In this combination the names of tables and attributes 
-- have been changed in order to follow a consistent naming 
-- convention throughout the entire DB.
------------------------------------
-----------------------------
--                         --
-- delete old stuff        --
--                         -- 
-----------------------------

-- In ORACLE tables can only be dropped 
-- if no foreign key points to them.
-- Hence we start droping the master tables
-- from the top, next we remove the M:N 
-- tables, next we remove all other tables
-- that hold a foreign key, and finally the
-- tables the have no foreign key.

-- Note that for the creation the reverse order
-- must be obeyed

-- We should use PURGE when on Oracle to make sure
-- that the database will get replicated without
-- problems

DROP TABLE trigger_log PURGE;
DROP TABLE trigger_schema PURGE;
DROP TABLE tt_users PURGE;

DROP TABLE l1_random_rates PURGE;

-- drop HLT Prescale alias
DROP TABLE hlt_prescale_set_alias PURGE;

-- drop L1 Prescale alias
DROP TABLE l1_prescale_set_alias PURGE;

-- drop trigger alias table
DROP TABLE trigger_alias PURGE;

-- drop next run table
DROP TABLE trigger_next_run PURGE;

-- specific order:
DROP TABLE HLT_SMT_TO_HRE PURGE;

-- drop master table first
DROP TABLE super_master_table PURGE;

---------------------------
-- drop the LVL1 tables

-- drop the master table first
DROP TABLE l1_master_table PURGE;

-- drop N-N tables
DROP TABLE l1_tm_to_ps PURGE;
DROP TABLE l1_tm_to_ti PURGE;
DROP TABLE l1_ti_to_tt PURGE;
DROP TABLE l1_tt_to_ttv PURGE;
DROP TABLE l1_pits PURGE;
DROP TABLE l1_tm_to_tt_mon PURGE;
DROP TABLE l1_tm_to_tt PURGE;
DROP TABLE l1_tm_to_tt_forced PURGE;
DROP TABLE l1_bgs_to_bg PURGE;
DROP TABLE l1_bg_to_b PURGE;
DROP TABLE l1_ci_to_csc PURGE;

-- drop tables with FK
DROP TABLE l1_prescale_set PURGE;
DROP TABLE l1_trigger_menu PURGE;

-- drop the rest
DROP TABLE l1_bunch_group_set PURGE;
DROP TABLE l1_bunch_group PURGE;
DROP TABLE l1_muctpi_info PURGE;
DROP TABLE l1_dead_time PURGE;
DROP TABLE l1_random PURGE;
DROP TABLE l1_prescaled_clock PURGE;
DROP TABLE l1_jet_input PURGE;
DROP TABLE l1_calo_sin_cos PURGE; 
DROP TABLE l1_ctp_files PURGE;
DROP TABLE l1_ctp_smx PURGE;
DROP TABLE l1_trigger_item PURGE;
DROP TABLE l1_trigger_threshold PURGE;
DROP TABLE l1_trigger_threshold_value PURGE;
DROP TABLE l1_calo_info PURGE;
DROP TABLE l1_muon_threshold_set PURGE;

------------------------------
-- drop the HLT tables

-- drop the master table first
DROP TABLE hlt_master_table PURGE;

-- drop the M-N tables
DROP TABLE hlt_cp_to_pa PURGE;
DROP TABLE hlt_cp_to_cp PURGE;
DROP TABLE hlt_st_to_cp PURGE;
DROP TABLE hlt_tm_to_tc PURGE;
DROP TABLE hlt_ts_to_te PURGE;
DROP TABLE hlt_te_to_te PURGE;
DROP TABLE hlt_tc_to_ts PURGE;
DROP TABLE hlt_te_to_cp PURGE;
DROP TABLE hlt_tc_to_tr PURGE;
DROP TABLE hlt_tm_to_ps PURGE;

-- drop M-N rule tables
DROP TABLE HLT_HRE_TO_HRS PURGE;
DROP TABLE HLT_HRS_TO_HRU PURGE;
DROP TABLE HLT_HRU_TO_HRC PURGE;
DROP TABLE HLT_HRC_TO_HRP PURGE;

-- drop the tables with FK
--DROP TABLE hlt_force_dll PURGE;
DROP TABLE hlt_prescale PURGE;
DROP TABLE hlt_prescale_set PURGE;
DROP TABLE hlt_trigger_group PURGE;
DROP TABLE hlt_trigger_type PURGE;
DROP TABLE hlt_trigger_signature PURGE;
DROP TABLE hlt_trigger_menu PURGE;
DROP TABLE hlt_trigger_chain PURGE;

-- drop the rest
DROP TABLE hlt_release PURGE;
DROP TABLE hlt_parameter PURGE;
DROP TABLE hlt_trigger_element PURGE;
DROP TABLE hlt_setup PURGE;
DROP TABLE hlt_component PURGE;
DROP TABLE hlt_trigger_stream PURGE;

-- drop rule tables
DROP TABLE HLT_RULE_SET PURGE;
DROP TABLE HLT_RULE PURGE;
DROP TABLE HLT_RULE_COMPONENT PURGE;
DROP TABLE HLT_RULE_PARAMETER PURGE;

-- drop table DBCOPY_SOURCE_DATABASE
DROP TABLE DBCOPY_SOURCE_DATABASE PURGE;

-----------------------------
--                         --
-- CREATE TABLEs           --
--                         -- 
-----------------------------

--------------------------------------------------
-- start with the LVL1 part

-------------------------------------------------
-- SQL script for the LVL1 trigger database
-- date  : 04.07.05
-- author: Johannes Haller (CERN)
-------------------------------------------------
------------------------------------------------
-- modifications by Nabil Iqbal: 5.7.05
-- added used, user, and modification time flags to ttv, tt, ti, tm fields
-- and to l1_tm_to_ti, l1_ti_to_tt, l1_tt_to_ttv, l1_tm_to_tt tables
-- added the same to various bunch group types, ttype, deadtime, muctpi, etc.
-- adding priority field to threshold value
-- note no Boolean datatype in Oracle SQL: using char instead.
-----------------------------------------------
-- more modifications by Nabil Iqbal 5.8.05
-- added uniqueness constraint on name and version for all applicable tables
-- made version into a real instead of a string (for programmatic adjustment
-- of version numbers)
-----------------------------

----------------------------
-- first the datatables
----------------------------

CREATE TABLE DBCOPY_SOURCE_DATABASE (
   NAME_OF_DB        VARCHAR2(200) 
);

-- Special table that describes the schema version
CREATE TABLE trigger_schema (
	ts_id 				NUMBER(10),
	ts_trigdb_tag			VARCHAR2(50),
	ts_trigtool_tag			VARCHAR2(50),
	CONSTRAINT			ts_id_NN 		CHECK ( ts_id IS NOT NULL),
	CONSTRAINT			ts_trigdb_tag_NN 	CHECK ( ts_trigdb_tag IS NOT NULL),
	CONSTRAINT			ts_trigtool_tag_NN 	CHECK ( ts_trigtool_tag IS NOT NULL),
	CONSTRAINT			ts_pk			PRIMARY KEY(ts_id)
);
INSERT INTO trigger_schema VALUES (1,"TrigDB-00-00-21","TriggerTool-01-01-17");
INSERT INTO trigger_schema VALUES (2,"NA","NA");
INSERT INTO trigger_schema VALUES (3,"NA","NA");
INSERT INTO trigger_schema VALUES (4,"NA","NA");
INSERT INTO trigger_schema VALUES (5,"NA","NA");
INSERT INTO trigger_schema VALUES (6,"TrigDB-00-00-39","TriggerTool-01-01-39-XX");
INSERT INTO trigger_schema VALUES (7,"TrigDB-00-01-04","TriggerTool-01-02-XX");

-- The users and their access rights
CREATE TABLE tt_users (
	tt_level VARCHAR2(50),
	tt_user  VARCHAR2(50),
	tt_password VARCHAR2(50),
	CONSTRAINT			tt_level_NN 		CHECK ( tt_level IS NOT NULL),
	CONSTRAINT			tt_user_NN 		CHECK ( tt_user IS NOT NULL),
	CONSTRAINT			tt_password_NN		CHECK ( tt_password IS NOT NULL)
);
insert into tt_users values("Trigger Meister", "simon", "KIIU7Tj2jKjONao70QwQew+IHAw=");

-- A list of valid rates for the drop down box on the edit-rate tab.  The actual
-- rate is stored into the l1_random table
CREATE TABLE l1_random_rates (
	l1rr_id				NUMBER(10), 
	l1rr_rate			VARCHAR2(30),
	l1rr_active_from		TIMESTAMP,	
	CONSTRAINT			l1rr_rate_NN 		CHECK ( l1rr_rate IS NOT NULL),
	CONSTRAINT			l1rr_active_from_NN 	CHECK ( l1rr_active_from IS NOT NULL)
);

-- l1 prescale set alias presented to the shift user
CREATE TABLE l1_prescale_set_alias (
	l1pa_id				NUMBER(10),
	l1pa_prescale_set_id		NUMBER(10),
	l1pa_alias 			VARCHAR2(50),
	l1pa_default		    	NUMBER(1)     		default 0,
	l1pa_username 			VARCHAR2(50),
	l1pa_modified_time 		TIMESTAMP,
	l1pa_used 			CHAR			default 0,       
	CONSTRAINT 			l1pa_pk			PRIMARY KEY(l1pa_id),
	CONSTRAINT			l1pa_id_NN 		CHECK ( l1pa_id IS NOT NULL),
	CONSTRAINT			l1pa_prescale_set_id_NN CHECK ( l1pa_prescale_set_id IS NOT NULL),
	CONSTRAINT			l1pa_alias_NN 		CHECK ( l1pa_alias IS NOT NULL),
	CONSTRAINT			l1pa_default_NN 	CHECK ( l1pa_default IS NOT NULL),
	CONSTRAINT			l1pa_used_NN 		CHECK ( l1pa_used IS NOT NULL)
);

-- hlt prescale set alias presented to the shift user
CREATE TABLE hlt_prescale_set_alias (
  	hpsa_id                 	NUMBER(10),
	hpsa_prescale_set_id    	NUMBER(10),
	hpsa_alias              	VARCHAR2(50),
	hpsa_default		    	NUMBER(1)     		default 0,
	hpsa_username           	VARCHAR2(50),
	hpsa_modified_time      	TIMESTAMP,
	hpsa_used               	CHAR			default 0,       
	CONSTRAINT   			hpsa_pk    		PRIMARY KEY(hpsa_id),
	CONSTRAINT			hpsa_id_NN 		CHECK ( hpsa_id IS NOT NULL),
	CONSTRAINT			hpsa_prescale_set_id_NN CHECK ( hpsa_prescale_set_id IS NOT NULL),
	CONSTRAINT			hpsa_alias_NN 		CHECK ( hpsa_alias IS NOT NULL),
	CONSTRAINT			hpsa_default_NN 	CHECK ( hpsa_default IS NOT NULL),
	CONSTRAINT			hpsa_used_NN 		CHECK ( hpsa_used IS NOT NULL)
);

-- trigger alias presented to the shift user
CREATE TABLE trigger_alias (
	tal_id                      	NUMBER(10),
	tal_super_master_table_id   	NUMBER(10),
	tal_trigger_alias           	VARCHAR2(50),
	tal_default		    	NUMBER(1)     		default 0,
	tal_username 		    	VARCHAR2(50),
	tal_modified_time           	TIMESTAMP,
	tal_used                    	CHAR			default 0,       
	CONSTRAINT     		   	tal_pk       		PRIMARY KEY(tal_id),
	CONSTRAINT			tal_id_NN 		CHECK ( tal_id IS NOT NULL),
	CONSTRAINT			tal_smt_id_NN 		CHECK ( tal_super_master_table_id IS NOT NULL),
	CONSTRAINT			tal_trigger_alias_NN 	CHECK ( tal_trigger_alias IS NOT NULL),
	CONSTRAINT			tal_default_NN 		CHECK ( tal_default IS NOT NULL),
	CONSTRAINT			tal_used_NN 		CHECK ( tal_used IS NOT NULL)
);

-- Here the MUCPTI object is stored.
-- Please note that these are actually LVL2 cuts
CREATE TABLE l1_muctpi_info (
	l1mi_id 			NUMBER(10),
	l1mi_name 			VARCHAR2(50),
	l1mi_version 			NUMBER(11),
	l1mi_low_pt 			NUMBER(10),
	l1mi_high_pt 			NUMBER(10),
	l1mi_max_cand 			NUMBER(10),
	l1mi_username			VARCHAR2(50),
	l1mi_modified_time		TIMESTAMP,
	l1mi_used			CHAR			default 0,       
	CONSTRAINT 			muctpi_pk 		PRIMARY KEY (l1mi_id),
	CONSTRAINT			muctpi_nmver		UNIQUE (l1mi_name, l1mi_version),
	CONSTRAINT			l1mi_id_NN 		CHECK ( l1mi_id IS NOT NULL),
	CONSTRAINT			l1mi_name_NN 		CHECK ( l1mi_name IS NOT NULL),
	CONSTRAINT			l1mi_version_NN 	CHECK ( l1mi_version IS NOT NULL),
	CONSTRAINT			l1mi_low_pt_NN 		CHECK ( l1mi_low_pt IS NOT NULL),
	CONSTRAINT			l1mi_high_pt_NN 	CHECK ( l1mi_high_pt IS NOT NULL),
	CONSTRAINT			l1mi_max_cand_NN 	CHECK ( l1mi_max_cand IS NOT NULL),
	CONSTRAINT			l1mi_used_NN 		CHECK ( l1mi_used IS NOT NULL)
);

-- Here the deadtime information is stored
CREATE TABLE l1_dead_time ( 
	l1dt_id 			NUMBER(10),
	l1dt_name 			VARCHAR2(50),
	l1dt_version 			NUMBER(11),
	l1dt_simple 			NUMBER(10),
	l1dt_complex1_rate 		NUMBER(10),
	l1dt_complex1_level		NUMBER(10),
	l1dt_complex2_rate 		NUMBER(10),
	l1dt_complex2_level		NUMBER(10),
	l1dt_username			VARCHAR2(50),
	l1dt_modified_time		TIMESTAMP,
	l1dt_used			CHAR			default 0,       		
	CONSTRAINT			l1dt_pk			PRIMARY KEY (l1dt_id),
	CONSTRAINT 			l1dt_nmver		UNIQUE (l1dt_name, l1dt_version),
	CONSTRAINT			l1dt_id_NN 		CHECK ( l1dt_id IS NOT NULL),
	CONSTRAINT			l1dt_name_NN 		CHECK ( l1dt_name IS NOT NULL),
	CONSTRAINT			l1dt_version_NN 	CHECK ( l1dt_version IS NOT NULL),
	CONSTRAINT			l1dt_simple_NN 		CHECK ( l1dt_simple IS NOT NULL),
	CONSTRAINT			l1dt_complex1_rate_NN 	CHECK ( l1dt_complex1_rate IS NOT NULL),
	CONSTRAINT			l1dt_complex1_level_NN 	CHECK ( l1dt_complex1_level IS NOT NULL),
	CONSTRAINT			l1dt_complex2_rate_NN 	CHECK ( l1dt_complex2_rate IS NOT NULL),
	CONSTRAINT			l1dt_complex2_level_NN 	CHECK ( l1dt_complex2_level IS NOT NULL),
	CONSTRAINT			l1dt_used_NN 		CHECK ( l1dt_used IS NOT NULL)
);

-- Here the RND trigger rates are stored
-- Note that these trigger rates could also be
-- treated as trigger threshold values.
-- Now we give a direct link from the trigger menu.
-- This allows to change the RND trigger rates without
-- changing the trigger items
CREATE TABLE l1_random (
	l1r_id 				NUMBER(10),
	l1r_name 			VARCHAR2(50),
	l1r_version 			NUMBER(11),
	l1r_rate1 			NUMBER(10),
	l1r_rate2 			NUMBER(10),
	l1r_autoseed1			NUMBER(1),
	l1r_autoseed2			NUMBER(1),
	l1r_seed1			NUMBER(10),
	l1r_seed2			NUMBER(10),
	l1r_username			VARCHAR2(50),
	l1r_modified_time		TIMESTAMP,
	l1r_used			CHAR			default 0,       
	CONSTRAINT			l1r_pk			PRIMARY KEY (l1r_id),
	CONSTRAINT			l1r_nmver		UNIQUE (l1r_name, l1r_version),
	CONSTRAINT			l1r_id_NN 		CHECK ( l1r_id IS NOT NULL),
	CONSTRAINT			l1r_name_NN 		CHECK ( l1r_name IS NOT NULL),
	CONSTRAINT			l1r_version_NN 		CHECK ( l1r_version IS NOT NULL),
	CONSTRAINT			l1r_rate1_NN 		CHECK ( l1r_rate1 IS NOT NULL),
	CONSTRAINT			l1r_rate2_NN 		CHECK ( l1r_rate2 IS NOT NULL),
	CONSTRAINT			l1r_autoseed1_NN 	CHECK ( l1r_autoseed1 IS NOT NULL),
	CONSTRAINT			l1r_autoseed2_NN 	CHECK ( l1r_autoseed2 IS NOT NULL),
	CONSTRAINT			l1r_seed1_NN 		CHECK ( l1r_seed1 IS NOT NULL),
	CONSTRAINT			l1r_seed2_NN 		CHECK ( l1r_seed2 IS NOT NULL),
	CONSTRAINT			l1r_used_NN 		CHECK ( l1r_used IS NOT NULL)
);

-- Here the two prescaled clocks of the CTP are stored.
-- Please note the additional remarks on the random triggers
-- which also apply here.
CREATE TABLE l1_prescaled_clock (
	l1pc_id 			NUMBER(10),
	l1pc_name 			VARCHAR2(50),
	l1pc_version 			NUMBER(11),
	l1pc_clock1 			NUMBER(10),
	l1pc_clock2 			NUMBER(10),
	l1pc_username 			VARCHAR2(50),
	l1pc_modified_time		TIMESTAMP,
	l1pc_used			CHAR			default 0,       
	CONSTRAINT			psc_pk			PRIMARY KEY (l1pc_id),
	CONSTRAINT			psc_nmver		UNIQUE (l1pc_name, l1pc_version),
	CONSTRAINT			l1pc_id_NN 		CHECK ( l1pc_id IS NOT NULL),
	CONSTRAINT			l1pc_name_NN 		CHECK ( l1pc_name IS NOT NULL),
	CONSTRAINT			l1pc_version_NN 	CHECK ( l1pc_version IS NOT NULL),
	CONSTRAINT			l1pc_clock1_NN 		CHECK ( l1pc_clock1 IS NOT NULL),
	CONSTRAINT			l1pc_clock2_NN 		CHECK ( l1pc_clock2 IS NOT NULL),
	CONSTRAINT			l1pc_used_NN 		CHECK ( l1pc_used IS NOT NULL)
);

-- two additional tables requested by L1Calo
CREATE TABLE l1_jet_input (
	l1ji_id 			NUMBER(10),
	l1ji_name 			VARCHAR2(50),
	l1ji_version 			NUMBER(11),
	l1ji_type			VARCHAR2(6),
	l1ji_value 			NUMBER(10),
	l1ji_eta_min 			NUMBER(10),
	l1ji_eta_max 			NUMBER(10),
	l1ji_phi_min 			NUMBER(10),
	l1ji_phi_max 			NUMBER(10),
	l1ji_username			VARCHAR2(50),
	l1ji_modified_time		TIMESTAMP,
	l1ji_used			CHAR			default 0,       
	CONSTRAINT			l1ji_pk			PRIMARY KEY (l1ji_id),
	CONSTRAINT 			l1ji_nmver		UNIQUE (l1ji_name, l1ji_version),
	CONSTRAINT			l1ji_id_NN 		CHECK ( l1ji_id IS NOT NULL),
	CONSTRAINT			l1ji_name_NN 		CHECK ( l1ji_name IS NOT NULL),
	CONSTRAINT			l1ji_version_NN 	CHECK ( l1ji_version IS NOT NULL),
	CONSTRAINT			l1ji_type_NN 		CHECK ( l1ji_type IS NOT NULL),
	CONSTRAINT			l1ji_value_NN 		CHECK ( l1ji_value IS NOT NULL),
	CONSTRAINT			l1ji_eta_min_NN 	CHECK ( l1ji_eta_min IS NOT NULL),
	CONSTRAINT			l1ji_eta_max_NN 	CHECK ( l1ji_eta_max IS NOT NULL),
	CONSTRAINT			l1ji_phi_min_NN 	CHECK ( l1ji_phi_min IS NOT NULL),
	CONSTRAINT			l1ji_phi_max_NN 	CHECK ( l1ji_phi_max IS NOT NULL),
	CONSTRAINT			l1ji_used_NN 		CHECK ( l1ji_used IS NOT NULL)
);

-- note the values for val1 to val8 should eb 8-bit integer
CREATE TABLE l1_calo_sin_cos (
	l1csc_id 			NUMBER(10),
	l1csc_name 			VARCHAR2(50),
	l1csc_version 			NUMBER(11),
	l1csc_val1 			NUMBER(10),
	l1csc_val2 			NUMBER(10),
	l1csc_val3 			NUMBER(10),
	l1csc_val4 			NUMBER(10),
	l1csc_val5 			NUMBER(10),
	l1csc_val6 			NUMBER(10),
	l1csc_val7 			NUMBER(10),
	l1csc_val8 			NUMBER(10),
	l1csc_eta_min 			NUMBER(10),
	l1csc_eta_max 			NUMBER(10),
	l1csc_phi_min 			NUMBER(10),
	l1csc_phi_max 			NUMBER(10),
	l1csc_username			VARCHAR2(50),
	l1csc_modified_time		TIMESTAMP,
	l1csc_used			CHAR			default 0,       
	CONSTRAINT			l1csc_pk		PRIMARY KEY (l1csc_id),
	CONSTRAINT			l1csc_nmver		UNIQUE (l1csc_name, l1csc_version),
	CONSTRAINT			l1csc_id_NN 		CHECK ( l1csc_id IS NOT NULL),
	CONSTRAINT			l1csc_name_NN 		CHECK ( l1csc_name IS NOT NULL),
	CONSTRAINT			l1csc_version_NN 	CHECK ( l1csc_version IS NOT NULL),
	CONSTRAINT			l1csc_val1_NN 		CHECK ( l1csc_val1 IS NOT NULL),
	CONSTRAINT			l1csc_val2_NN 		CHECK ( l1csc_val2 IS NOT NULL),
	CONSTRAINT			l1csc_val3_NN 		CHECK ( l1csc_val3 IS NOT NULL),
	CONSTRAINT			l1csc_val4_NN 		CHECK ( l1csc_val4 IS NOT NULL),
	CONSTRAINT			l1csc_val5_NN 		CHECK ( l1csc_val5 IS NOT NULL),
	CONSTRAINT			l1csc_val6_NN 		CHECK ( l1csc_val6 IS NOT NULL),
	CONSTRAINT			l1csc_val7_NN 		CHECK ( l1csc_val7 IS NOT NULL),
	CONSTRAINT			l1csc_val8_NN 		CHECK ( l1csc_val8 IS NOT NULL),
	CONSTRAINT			l1csc_eta_min_NN 	CHECK ( l1csc_eta_min IS NOT NULL),
	CONSTRAINT			l1csc_eta_max_NN 	CHECK ( l1csc_eta_max IS NOT NULL),
	CONSTRAINT			l1csc_phi_min_NN 	CHECK ( l1csc_phi_min IS NOT NULL),
	CONSTRAINT			l1csc_phi_max_NN 	CHECK ( l1csc_phi_max IS NOT NULL),
	CONSTRAINT			l1csc_used_NN 		CHECK ( l1csc_used IS NOT NULL)
);

-- Here the bunchgroup sets are defined. These sets are
-- maximum 8 bunch groups. Here again we give a direct link
-- from the trigger menu in order to change the definition
-- of bunchgroups without changing the definition of the
-- trigger items. In their definition only the BG is specified
-- from the set of BGs associated to the trigger menu.
CREATE TABLE l1_bunch_group_set (
	l1bgs_id			NUMBER(10),
	l1bgs_name 			VARCHAR2(50),
	l1bgs_version			NUMBER(11),
        l1bgs_comment			VARCHAR2(200),
	l1bgs_username			VARCHAR2(50),
	l1bgs_modified_time		TIMESTAMP,
	l1bgs_used			CHAR			default 0,       
	CONSTRAINT			l1bgs_pk		PRIMARY KEY (l1bgs_id),
	CONSTRAINT			l1bgs_nmver		UNIQUE (l1bgs_name, l1bgs_version),
	CONSTRAINT			l1bgs_id_NN 		CHECK ( l1bgs_id IS NOT NULL),
	CONSTRAINT			l1bgs_name_NN 		CHECK ( l1bgs_name IS NOT NULL),
	CONSTRAINT			l1bgs_version_NN 	CHECK ( l1bgs_version IS NOT NULL),
	CONSTRAINT			l1bgs_used_NN 		CHECK ( l1bgs_used IS NOT NULL)
);		

-- defines the bunch groups used in the bunch group sets above
CREATE TABLE l1_bunch_group (
	l1bg_id				NUMBER(10),
	l1bg_name 			VARCHAR2(50),
	l1bg_version			NUMBER(11),
	l1bg_comment			VARCHAR2(200),
	l1bg_username			VARCHAR2(50),
	l1bg_modified_time		TIMESTAMP,
	l1bg_used			CHAR			default 0,       
	CONSTRAINT			l1bg_pk			PRIMARY KEY (l1bg_id),
	CONSTRAINT 			l1bg_nmver		UNIQUE (l1bg_name, l1bg_version),
	CONSTRAINT			l1bg_id_NN 		CHECK ( l1bg_id IS NOT NULL),
	CONSTRAINT			l1bg_name_NN 		CHECK ( l1bg_name IS NOT NULL),
	CONSTRAINT			l1bg_version_NN 	CHECK ( l1bg_version IS NOT NULL),
	CONSTRAINT			l1bg_used_NN 		CHECK ( l1bg_used IS NOT NULL)
);

-- In this table the CTP HW files are stored. THis table is referenced
-- by the trigger_menu. There is one entry of ctp_hw_files for each L1_menu;
CREATE TABLE l1_ctp_files ( 
	l1cf_id 			NUMBER(10),
	l1cf_name 			VARCHAR2(50),
	l1cf_version 			NUMBER(11),
	l1cf_lut			CLOB,
	l1cf_cam			CLOB,	
	l1cf_mon_sel_slot7		CLOB,
	l1cf_mon_sel_slot8		CLOB,
	l1cf_mon_sel_slot9		CLOB,
	l1cf_mon_sel_ctpmon		CLOB,
	l1cf_mon_dec_slot7		CLOB,
	l1cf_mon_dec_slot8		CLOB,
	l1cf_mon_dec_slot9		CLOB,
	l1cf_mon_dec_ctpmon		CLOB,
	l1cf_username			VARCHAR2(50),
	l1cf_modified_time		TIMESTAMP,
	l1cf_used			CHAR			default 0,       
	CONSTRAINT 			l1cf_pk			PRIMARY KEY (l1cf_id),
	CONSTRAINT 			l1cf_nmver		UNIQUE (l1cf_name, l1cf_version),
	CONSTRAINT			l1cf_id_NN 		CHECK ( l1cf_id IS NOT NULL),
	CONSTRAINT			l1cf_name_NN 		CHECK ( l1cf_name IS NOT NULL),
	CONSTRAINT			l1cf_version_NN 	CHECK ( l1cf_version IS NOT NULL),
	CONSTRAINT			l1cf_used_NN 		CHECK ( l1cf_used IS NOT NULL)
);

-- In this table the switch matrix input files are stored, as well as their 
-- associated vhdl and binary files. This table is referenced by the trigger_menu.
CREATE TABLE l1_ctp_smx (
	l1smx_id			NUMBER(10),
	l1smx_name 			VARCHAR2(50),
	l1smx_version			NUMBER(11),
	l1smx_output			CLOB,
	l1smx_vhdl_slot7		CLOB,
	l1smx_vhdl_slot8		CLOB,
	l1smx_vhdl_slot9		CLOB,
	l1smx_svfi_slot7		CLOB,
	l1smx_svfi_slot8		CLOB,
	l1smx_svfi_slot9		CLOB,		
	l1smx_username			VARCHAR2(50),
	l1smx_modified_time		TIMESTAMP,
	l1smx_used			CHAR			default 0,       
	CONSTRAINT			l1smx_pk		PRIMARY KEY (l1smx_id),
	CONSTRAINT			l1smx_nmver		UNIQUE (l1smx_name, l1smx_version),
	CONSTRAINT			l1smx_id_NN 		CHECK ( l1smx_id IS NOT NULL),
	CONSTRAINT			l1smx_name_NN 		CHECK ( l1smx_name IS NOT NULL),
	CONSTRAINT			l1smx_version_NN 	CHECK ( l1smx_version IS NOT NULL),
	CONSTRAINT			l1smx_used_NN 		CHECK ( l1smx_used IS NOT NULL)
); 

-- The trigger menu. There are refrences to information stored
-- in other tables. Each change of this information requires a 
-- version update of the trigger menu. Please note that the 
-- random trigger rates, the prescaled clocks, and the bunch group
-- sets are defined here. 	
-- Note that the reference to the prescale set only gives the default
-- prescale of this trigger menu. The actual used prescales are stored
-- in the master table
-- There is a foreign key to the ctp_hw_files attributed to this menu.
-- There is a foreign key to the ctp_smx_files attributed to this menu.
CREATE TABLE l1_trigger_menu (
	l1tm_id 			NUMBER(10),
	l1tm_name 			VARCHAR2(50),
	l1tm_version 			NUMBER(11),
	l1tm_phase 			VARCHAR2(50),
	l1tm_ctp_safe			NUMBER(1),
	l1tm_ctp_files_id		NUMBER(10),
	l1tm_ctp_smx_id			NUMBER(10),
	l1tm_username			VARCHAR2(50),
	l1tm_modified_time		TIMESTAMP,
	l1tm_used			CHAR			default 0,       
	CONSTRAINT			l1tm_fk_cf		FOREIGN KEY (l1tm_ctp_files_id)
								REFERENCES l1_ctp_files(l1cf_id),
	CONSTRAINT			l1tm_fk_smx		FOREIGN KEY (l1tm_ctp_smx_id)
								REFERENCES l1_ctp_smx(l1smx_id),
	CONSTRAINT 			l1tm_pk			PRIMARY KEY (l1tm_id),
	CONSTRAINT 			l1tm_nmver		UNIQUE (l1tm_name, l1tm_version),
	CONSTRAINT			l1tm_id_NN 		CHECK ( l1tm_id IS NOT NULL),
	CONSTRAINT			l1tm_name_NN 		CHECK ( l1tm_name IS NOT NULL),
	CONSTRAINT			l1tm_version_NN 	CHECK ( l1tm_version IS NOT NULL),
	CONSTRAINT			l1tm_phase_NN 		CHECK ( l1tm_phase IS NOT NULL),
	CONSTRAINT			l1tm_ctp_safe_NN 	CHECK ( l1tm_ctp_safe IS NOT NULL),
	CONSTRAINT			l1tm_used_NN 		CHECK ( l1tm_used IS NOT NULL)
);
CREATE INDEX l1tm_ctp_files_id_ind ON l1_trigger_menu(l1tm_ctp_files_id);
CREATE INDEX l1tm_ctp_smx_id_ind   ON l1_trigger_menu(l1tm_ctp_smx_id);


-- This is a list of trigger items. The ti_definiton is a encoded
-- logical expression. The amount of logical expression in LVL1 trigger
-- menus will be limited. 95 percents of the cases are simple AND
-- connections. No need to install something more sophisticated. Can
-- be changed easily. ti_group is just a variable to bring an 
-- overview into the many trigger-items.
CREATE TABLE l1_trigger_item (
	l1ti_id 			NUMBER(10), 	
	l1ti_name 			VARCHAR2(50), 	
	l1ti_version 			NUMBER(11),	
	l1ti_comment			VARCHAR2(50),	
	l1ti_ctp_id			NUMBER(10), 	
	l1ti_priority			VARCHAR2(6),	
	l1ti_definition			VARCHAR2(64),	
	l1ti_group			NUMBER(10),	
	l1ti_trigger_type		NUMBER(4), 	
	l1ti_username			VARCHAR2(50),
	l1ti_modified_time		TIMESTAMP,
	l1ti_used			CHAR			default 0,
	CONSTRAINT			l1ti_pk			PRIMARY KEY (l1ti_id),
	CONSTRAINT			l1ti_nmver		UNIQUE (l1ti_name, l1ti_version),
	CONSTRAINT			l1ti_id_NN 		CHECK ( l1ti_id IS NOT NULL),
	CONSTRAINT			l1ti_name_NN 		CHECK ( l1ti_name IS NOT NULL),
	CONSTRAINT			l1ti_version_NN 	CHECK ( l1ti_version IS NOT NULL),
	CONSTRAINT			l1ti_ctp_id_NN 		CHECK ( l1ti_ctp_id IS NOT NULL),
	CONSTRAINT			l1ti_priority_NN 	CHECK ( l1ti_priority IS NOT NULL),
	CONSTRAINT			l1ti_definition_NN 	CHECK ( l1ti_definition IS NOT NULL),
	CONSTRAINT			l1ti_group_NN 		CHECK ( l1ti_group IS NOT NULL),
	CONSTRAINT			l1ti_used_NN 		CHECK ( l1ti_used IS NOT NULL)
);

-- This table gives a list a trigger thresholds. Please note that
-- also the RNDs, PSC and BG are listed here.  
CREATE TABLE l1_trigger_threshold (
	l1tt_id 			NUMBER(10),
	l1tt_name 			VARCHAR2(50),
	l1tt_version 			NUMBER(11),
	l1tt_type 			VARCHAR2(6),
	l1tt_bitnum 			NUMBER(10),
	l1tt_active     		NUMBER(1),
	l1tt_mapping    		NUMBER(10),
	l1tt_username			VARCHAR2(50),
	l1tt_modified_time		TIMESTAMP,
	l1tt_used			CHAR			default 0,
	CONSTRAINT			l1tt_pk			PRIMARY KEY (l1tt_id),
	CONSTRAINT 			l1tt_nmver		UNIQUE (l1tt_name, l1tt_version),
	CONSTRAINT			l1tt_id_NN 		CHECK ( l1tt_id IS NOT NULL),
	CONSTRAINT			l1tt_name_NN 		CHECK ( l1tt_name IS NOT NULL),
	CONSTRAINT			l1tt_version_NN 	CHECK ( l1tt_version IS NOT NULL),
	CONSTRAINT			l1tt_type_NN 		CHECK ( l1tt_type IS NOT NULL),
	CONSTRAINT			l1tt_bitnum_NN 		CHECK ( l1tt_bitnum IS NOT NULL),
	CONSTRAINT			l1tt_mapping_NN 	CHECK ( l1tt_mapping IS NOT NULL),
	CONSTRAINT			l1tt_used_NN 		CHECK ( l1tt_used IS NOT NULL)
);

-- This table holds a list of all trigger threshold values. This
-- is relevant for all calo thresholds which could be angular dependent.
-- For muon thresholds we re-use the same table because of simplicity.
-- Aslo the RND, PSC and BG are listed here. The pt_cut value of thes
-- thresholds are the reference to the list attched to the trigger menu.
-- e.g. a BG with ptcut=4, means the BG that is attached to the trigger
-- menu via the BG set and has an internal number of 4.
CREATE TABLE l1_trigger_threshold_value (
	l1ttv_id 			NUMBER(10),
	l1ttv_name 			VARCHAR2(50),
	l1ttv_version 			NUMBER(11),
	l1ttv_type			VARCHAR2(10),
	l1ttv_pt_cut 			VARCHAR2(10),
	l1ttv_eta_min 			NUMBER(10),
	l1ttv_eta_max 			NUMBER(10),
	l1ttv_phi_min 			NUMBER(10),
	l1ttv_phi_max 			NUMBER(10),
	l1ttv_em_isolation 		VARCHAR2(10),
	l1ttv_had_isolation 		VARCHAR2(10),
	l1ttv_had_veto 			VARCHAR2(10),
	l1ttv_window 			NUMBER(10),
	l1ttv_priority			VARCHAR2(10),
	l1ttv_username			VARCHAR2(50),
	l1ttv_modified_time		TIMESTAMP,
	l1ttv_used			CHAR			default 0,
	CONSTRAINT			l1ttv_pk		PRIMARY KEY (l1ttv_id),
	CONSTRAINT			l1ttv_nmver		UNIQUE (l1ttv_name, l1ttv_version),
	CONSTRAINT			l1ttv_id_NN 		CHECK ( l1ttv_id IS NOT NULL),
	CONSTRAINT			l1ttv_name_NN 		CHECK ( l1ttv_name IS NOT NULL),
	CONSTRAINT			l1ttv_version_NN 	CHECK ( l1ttv_version IS NOT NULL),
	CONSTRAINT			l1ttv_type_NN 		CHECK ( l1ttv_type IS NOT NULL),
	CONSTRAINT			l1ttv_pt_cut_NN 	CHECK ( l1ttv_pt_cut IS NOT NULL),
	CONSTRAINT			l1ttv_used_NN 		CHECK ( l1ttv_used IS NOT NULL)
);


CREATE TABLE l1_calo_info (
        l1ci_id         	        NUMBER(10),  
        l1ci_name	                VARCHAR2(50),
        l1ci_version                    NUMBER(11),  
	l1ci_global_scale		VARCHAR2(10),
	l1ci_jet_weight1		NUMBER(10),
	l1ci_jet_weight2		NUMBER(10),
	l1ci_jet_weight3		NUMBER(10),
	l1ci_jet_weight4		NUMBER(10),
	l1ci_jet_weight5		NUMBER(10),
	l1ci_jet_weight6		NUMBER(10),
	l1ci_jet_weight7		NUMBER(10),
	l1ci_jet_weight8		NUMBER(10),
	l1ci_jet_weight9		NUMBER(10),
	l1ci_jet_weight10		NUMBER(10),
	l1ci_jet_weight11		NUMBER(10),
	l1ci_jet_weight12		NUMBER(10),
	l1ci_username      	        VARCHAR2(50) ,
        l1ci_modified_time 		TIMESTAMP,
        l1ci_used               	CHAR			default 0,
        CONSTRAINT              	l1ci_pk        		PRIMARY KEY (l1ci_id),
	CONSTRAINT			l1ci_id_NN 		CHECK ( l1ci_id IS NOT NULL),
	CONSTRAINT			l1ci_name_NN 		CHECK ( l1ci_name IS NOT NULL),
	CONSTRAINT			l1civ_version_NN 	CHECK ( l1ci_version IS NOT NULL),
	CONSTRAINT			l1ci_global_scale_NN 	CHECK ( l1ci_global_scale IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight1_NN 	CHECK ( l1ci_jet_weight1 IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight2_NN 	CHECK ( l1ci_jet_weight2 IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight3_NN 	CHECK ( l1ci_jet_weight3 IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight4_NN 	CHECK ( l1ci_jet_weight4 IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight5_NN 	CHECK ( l1ci_jet_weight5 IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight6_NN 	CHECK ( l1ci_jet_weight6 IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight7_NN 	CHECK ( l1ci_jet_weight7 IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight8_NN 	CHECK ( l1ci_jet_weight8 IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight9_NN 	CHECK ( l1ci_jet_weight9 IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight10_NN 	CHECK ( l1ci_jet_weight10 IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight11_NN 	CHECK ( l1ci_jet_weight11 IS NOT NULL),
	CONSTRAINT			l1ci_jet_weight12_NN 	CHECK ( l1ci_jet_weight12 IS NOT NULL),
	CONSTRAINT			l1ci_used_NN 		CHECK ( l1ci_used IS NOT NULL)
);	

-- This table holds the list of available threshold sets for the
-- Lvl1 muon trigger. The configured thresholds must map on to the 
-- the values and the position of one of the available threshold sets
-- or the corresponding configuration is not viable. This table
-- should not be referenced directly, as it may move to the muon trigger
-- world. It is used by the trigger tool to verify configurations.

CREATE TABLE l1_muon_threshold_set (
	l1mts_id 		       	NUMBER(10), 
	l1mts_name 		       	VARCHAR2(200),
	l1mts_version 		       	NUMBER(11),	
	l1mts_rpc_available	       	NUMBER(1),	
	l1mts_rpc_available_online     	NUMBER(1),	
	l1mts_rpc_set_ext_id 		NUMBER(10), 	
	l1mts_rpc_set_name 		VARCHAR2(200), 	
	l1mts_rpc_pt1_ext_id 		NUMBER(10), 	
	l1mts_rpc_pt2_ext_id 		NUMBER(10), 	
	l1mts_rpc_pt3_ext_id 		NUMBER(10), 	
	l1mts_rpc_pt4_ext_id 		NUMBER(10), 	
	l1mts_rpc_pt5_ext_id 		NUMBER(10), 	
	l1mts_rpc_pt6_ext_id 		NUMBER(10), 	
	l1mts_tgc_available  		NUMBER(1),	
	l1mts_tgc_available_online 	NUMBER(1),      
        l1mts_tgc_set_ext_id 		NUMBER(10), 	
        l1mts_tgc_set_name 		VARCHAR2(200), 	
	l1mts_username		 	VARCHAR2(50),
	l1mts_modified_time	 	TIMESTAMP,
	l1mts_used		 	CHAR			default 0,
	CONSTRAINT		 	l1mts_pk		PRIMARY KEY (l1mts_id),
	CONSTRAINT 		 	l1mts_nmver		UNIQUE (l1mts_name, l1mts_version),
	CONSTRAINT			l1mts_id_NN 		CHECK ( l1mts_id IS NOT NULL),
	CONSTRAINT			l1mts_name_NN 		CHECK ( l1mts_name IS NOT NULL),
	CONSTRAINT			l1mts_version_NN 	CHECK ( l1mts_version IS NOT NULL),
	CONSTRAINT			l1mts_rpc_avail_NN 	CHECK ( l1mts_rpc_available IS NOT NULL),
	CONSTRAINT			l1mts_rpc_avail_onl_NN 	CHECK ( l1mts_rpc_available_online IS NOT NULL),
	CONSTRAINT			l1mts_rpc_set_ext_id_NN CHECK ( l1mts_rpc_set_ext_id IS NOT NULL),
	CONSTRAINT			l1mts_rpc_set_name_NN 	CHECK ( l1mts_rpc_set_name IS NOT NULL),
	CONSTRAINT			l1mts_rpc_pt1_ext_id_NN CHECK ( l1mts_rpc_pt1_ext_id IS NOT NULL),
	CONSTRAINT			l1mts_rpc_pt2_ext_id_NN CHECK ( l1mts_rpc_pt2_ext_id IS NOT NULL),
	CONSTRAINT			l1mts_rpc_pt3_ext_id_NN CHECK ( l1mts_rpc_pt3_ext_id IS NOT NULL),
	CONSTRAINT			l1mts_rpc_pt4_ext_id_NN CHECK ( l1mts_rpc_pt4_ext_id IS NOT NULL),
	CONSTRAINT			l1mts_rpc_pt5_ext_id_NN CHECK ( l1mts_rpc_pt5_ext_id IS NOT NULL),
	CONSTRAINT			l1mts_rpc_pt6_ext_id_NN CHECK ( l1mts_rpc_pt6_ext_id IS NOT NULL),
	CONSTRAINT			l1mts_tgc_avail_NN 	CHECK ( l1mts_tgc_available IS NOT NULL),
	CONSTRAINT			l1mts_tgc_avail_onl_NN 	CHECK ( l1mts_tgc_available_online IS NOT NULL),
	CONSTRAINT			l1mts_tgc_set_ext_id_NN CHECK ( l1mts_tgc_set_ext_id IS NOT NULL),
	CONSTRAINT			l1mts_tgc_set_name_NN 	CHECK ( l1mts_tgc_set_name IS NOT NULL),
	CONSTRAINT			l1mts_used_NN 		CHECK ( l1mts_used IS NOT NULL)
);


-- In this table the prescale factors for the
-- trigger items are stored
CREATE TABLE l1_prescale_set (
	l1ps_id				NUMBER(10),
	l1ps_name			VARCHAR2(65),
	l1ps_version			NUMBER(11),
        l1ps_comment			VARCHAR2(200),
	l1ps_lumi			VARCHAR2(10),
	l1ps_shift_safe			NUMBER(1),
	l1ps_default			NUMBER(1),
	l1ps_val1			NUMBER(10),
	l1ps_val2			NUMBER(10),
	l1ps_val3			NUMBER(10),
	l1ps_val4			NUMBER(10),
	l1ps_val5			NUMBER(10),
	l1ps_val6			NUMBER(10),
	l1ps_val7			NUMBER(10),
	l1ps_val8			NUMBER(10),
	l1ps_val9			NUMBER(10),
	l1ps_val10			NUMBER(10),
	l1ps_val11			NUMBER(10),
	l1ps_val12			NUMBER(10),
	l1ps_val13			NUMBER(10),
	l1ps_val14			NUMBER(10),
	l1ps_val15			NUMBER(10),
	l1ps_val16			NUMBER(10),
	l1ps_val17			NUMBER(10),
	l1ps_val18			NUMBER(10),
	l1ps_val19			NUMBER(10),
	l1ps_val20			NUMBER(10),
	l1ps_val21			NUMBER(10),
	l1ps_val22			NUMBER(10),
	l1ps_val23			NUMBER(10),
	l1ps_val24			NUMBER(10),
	l1ps_val25			NUMBER(10),
	l1ps_val26			NUMBER(10),
	l1ps_val27			NUMBER(10),
	l1ps_val28			NUMBER(10),
	l1ps_val29			NUMBER(10),
	l1ps_val30			NUMBER(10),
	l1ps_val31			NUMBER(10),
	l1ps_val32			NUMBER(10),
	l1ps_val33			NUMBER(10),
	l1ps_val34			NUMBER(10),
	l1ps_val35			NUMBER(10),
	l1ps_val36			NUMBER(10),
	l1ps_val37			NUMBER(10),
	l1ps_val38			NUMBER(10),
	l1ps_val39			NUMBER(10),
	l1ps_val40			NUMBER(10),
	l1ps_val41			NUMBER(10),
	l1ps_val42			NUMBER(10),
	l1ps_val43			NUMBER(10),
	l1ps_val44			NUMBER(10),
	l1ps_val45			NUMBER(10),
	l1ps_val46			NUMBER(10),
	l1ps_val47			NUMBER(10),
	l1ps_val48			NUMBER(10),
	l1ps_val49			NUMBER(10),
	l1ps_val50			NUMBER(10),
	l1ps_val51			NUMBER(10),
	l1ps_val52			NUMBER(10),
	l1ps_val53			NUMBER(10),
	l1ps_val54			NUMBER(10),
	l1ps_val55			NUMBER(10),
	l1ps_val56			NUMBER(10),
	l1ps_val57			NUMBER(10),
	l1ps_val58			NUMBER(10),
	l1ps_val59			NUMBER(10),
	l1ps_val60			NUMBER(10),
	l1ps_val61			NUMBER(10),
	l1ps_val62			NUMBER(10),
	l1ps_val63			NUMBER(10),
	l1ps_val64			NUMBER(10),
	l1ps_val65			NUMBER(10),
	l1ps_val66			NUMBER(10),
	l1ps_val67			NUMBER(10),
	l1ps_val68			NUMBER(10),
	l1ps_val69			NUMBER(10),
	l1ps_val70			NUMBER(10),
	l1ps_val71			NUMBER(10),
	l1ps_val72			NUMBER(10),
	l1ps_val73			NUMBER(10),
	l1ps_val74			NUMBER(10),
	l1ps_val75			NUMBER(10),
	l1ps_val76			NUMBER(10),
	l1ps_val77			NUMBER(10),
	l1ps_val78			NUMBER(10),
	l1ps_val79			NUMBER(10),
	l1ps_val80			NUMBER(10),
	l1ps_val81			NUMBER(10),
	l1ps_val82			NUMBER(10),
	l1ps_val83			NUMBER(10),
	l1ps_val84			NUMBER(10),
	l1ps_val85			NUMBER(10),
	l1ps_val86			NUMBER(10),
	l1ps_val87			NUMBER(10),
	l1ps_val88			NUMBER(10),
	l1ps_val89			NUMBER(10),
	l1ps_val90			NUMBER(10),
	l1ps_val91			NUMBER(10),
	l1ps_val92			NUMBER(10),
	l1ps_val93			NUMBER(10),
	l1ps_val94			NUMBER(10),
	l1ps_val95			NUMBER(10),
	l1ps_val96			NUMBER(10),
	l1ps_val97			NUMBER(10),
	l1ps_val98			NUMBER(10),
	l1ps_val99			NUMBER(10),
	l1ps_val100			NUMBER(10),
	l1ps_val101			NUMBER(10),
	l1ps_val102			NUMBER(10),
	l1ps_val103			NUMBER(10),
	l1ps_val104			NUMBER(10),
	l1ps_val105			NUMBER(10),
	l1ps_val106			NUMBER(10),
	l1ps_val107			NUMBER(10),
	l1ps_val108			NUMBER(10),
	l1ps_val109			NUMBER(10),
	l1ps_val110			NUMBER(10),
	l1ps_val111			NUMBER(10),
	l1ps_val112			NUMBER(10),
	l1ps_val113			NUMBER(10),
	l1ps_val114			NUMBER(10),
	l1ps_val115			NUMBER(10),
	l1ps_val116			NUMBER(10),
	l1ps_val117			NUMBER(10),
	l1ps_val118			NUMBER(10),
	l1ps_val119			NUMBER(10),
	l1ps_val120			NUMBER(10),
	l1ps_val121			NUMBER(10),
	l1ps_val122			NUMBER(10),
	l1ps_val123			NUMBER(10),
	l1ps_val124			NUMBER(10),
	l1ps_val125			NUMBER(10),
	l1ps_val126			NUMBER(10),
	l1ps_val127			NUMBER(10),
	l1ps_val128			NUMBER(10),
	l1ps_val129			NUMBER(10),
	l1ps_val130			NUMBER(10),
	l1ps_val131			NUMBER(10),
	l1ps_val132			NUMBER(10),
	l1ps_val133			NUMBER(10),
	l1ps_val134			NUMBER(10),
	l1ps_val135			NUMBER(10),
	l1ps_val136			NUMBER(10),
	l1ps_val137			NUMBER(10),
	l1ps_val138			NUMBER(10),
	l1ps_val139			NUMBER(10),
	l1ps_val140			NUMBER(10),
	l1ps_val141			NUMBER(10),
	l1ps_val142			NUMBER(10),
	l1ps_val143			NUMBER(10),
	l1ps_val144			NUMBER(10),
	l1ps_val145			NUMBER(10),
	l1ps_val146			NUMBER(10),
	l1ps_val147			NUMBER(10),
	l1ps_val148			NUMBER(10),
	l1ps_val149			NUMBER(10),
	l1ps_val150			NUMBER(10),	
	l1ps_val151			NUMBER(10),
	l1ps_val152			NUMBER(10),	
	l1ps_val153			NUMBER(10),	
	l1ps_val154			NUMBER(10),	
	l1ps_val155			NUMBER(10),	
	l1ps_val156			NUMBER(10),	
	l1ps_val157			NUMBER(10),	
	l1ps_val158			NUMBER(10),	
	l1ps_val159			NUMBER(10),	
	l1ps_val160			NUMBER(10),	
	l1ps_val161			NUMBER(10),	
	l1ps_val162			NUMBER(10),	
	l1ps_val163			NUMBER(10),	
	l1ps_val164			NUMBER(10),	
	l1ps_val165			NUMBER(10),	
	l1ps_val166			NUMBER(10),	
	l1ps_val167			NUMBER(10),	
	l1ps_val168			NUMBER(10),	
	l1ps_val169			NUMBER(10),	
	l1ps_val170			NUMBER(10),	
	l1ps_val171			NUMBER(10),	
	l1ps_val172			NUMBER(10),	
	l1ps_val173			NUMBER(10),	
	l1ps_val174			NUMBER(10),	
	l1ps_val175			NUMBER(10),	
	l1ps_val176			NUMBER(10),	
	l1ps_val177			NUMBER(10),	
	l1ps_val178			NUMBER(10),	
	l1ps_val179			NUMBER(10),	
	l1ps_val180			NUMBER(10),	
	l1ps_val181			NUMBER(10),	
	l1ps_val182			NUMBER(10),	
	l1ps_val183			NUMBER(10),	
	l1ps_val184			NUMBER(10),	
	l1ps_val185			NUMBER(10),	
	l1ps_val186			NUMBER(10),	
	l1ps_val187			NUMBER(10),	
	l1ps_val188			NUMBER(10),	
	l1ps_val189			NUMBER(10),	
	l1ps_val190			NUMBER(10),	
	l1ps_val191			NUMBER(10),	
	l1ps_val192			NUMBER(10),	
	l1ps_val193			NUMBER(10),	
	l1ps_val194			NUMBER(10),	
	l1ps_val195			NUMBER(10),	
	l1ps_val196			NUMBER(10),	
	l1ps_val197			NUMBER(10),	
	l1ps_val198			NUMBER(10),	
	l1ps_val199			NUMBER(10),
	l1ps_val200			NUMBER(10),
	l1ps_val201			NUMBER(10),
	l1ps_val202			NUMBER(10),
	l1ps_val203			NUMBER(10),
	l1ps_val204			NUMBER(10),
	l1ps_val205			NUMBER(10),
	l1ps_val206			NUMBER(10),
	l1ps_val207			NUMBER(10),
	l1ps_val208			NUMBER(10),
	l1ps_val209			NUMBER(10),
	l1ps_val210			NUMBER(10),
	l1ps_val211			NUMBER(10),
	l1ps_val212			NUMBER(10),
	l1ps_val213			NUMBER(10),
	l1ps_val214			NUMBER(10),
	l1ps_val215			NUMBER(10),
	l1ps_val216			NUMBER(10),
	l1ps_val217			NUMBER(10),
	l1ps_val218			NUMBER(10),
	l1ps_val219			NUMBER(10),
	l1ps_val220			NUMBER(10),
	l1ps_val221			NUMBER(10),
	l1ps_val222			NUMBER(10),
	l1ps_val223			NUMBER(10),
	l1ps_val224			NUMBER(10),
	l1ps_val225			NUMBER(10),
	l1ps_val226			NUMBER(10),
	l1ps_val227			NUMBER(10),
	l1ps_val228			NUMBER(10),
	l1ps_val229			NUMBER(10),
	l1ps_val230			NUMBER(10),	
	l1ps_val231			NUMBER(10),	
	l1ps_val232			NUMBER(10),	
	l1ps_val233			NUMBER(10),	
	l1ps_val234			NUMBER(10),	
	l1ps_val235			NUMBER(10),	
	l1ps_val236			NUMBER(10),	
	l1ps_val237			NUMBER(10),	
	l1ps_val238			NUMBER(10),	
	l1ps_val239			NUMBER(10),	
	l1ps_val240			NUMBER(10),	
	l1ps_val241			NUMBER(10),	
	l1ps_val242			NUMBER(10),	
	l1ps_val243			NUMBER(10),	
	l1ps_val244			NUMBER(10),	
	l1ps_val245			NUMBER(10),	
	l1ps_val246			NUMBER(10),	
	l1ps_val247			NUMBER(10),	
	l1ps_val248			NUMBER(10),	
	l1ps_val249			NUMBER(10),	
	l1ps_val250			NUMBER(10),	
	l1ps_val251			NUMBER(10),	
	l1ps_val252			NUMBER(10),	
	l1ps_val253			NUMBER(10),	
	l1ps_val254			NUMBER(10),	
	l1ps_val255			NUMBER(10),	
	l1ps_val256			NUMBER(10),	
	l1ps_username			VARCHAR2(50),
	l1ps_modified_time		TIMESTAMP,
	l1ps_used			CHAR			default 0,
	CONSTRAINT			l1ps_pk			PRIMARY KEY (l1ps_id),
	CONSTRAINT 			l1ps_nmver		UNIQUE (l1ps_name, l1ps_version),
	CONSTRAINT			l1ps_id_NN 		CHECK ( l1ps_id IS NOT NULL),
	CONSTRAINT			l1ps_name_NN 		CHECK ( l1ps_name IS NOT NULL),
	CONSTRAINT			l1ps_version_NN 	CHECK ( l1ps_version IS NOT NULL),
	CONSTRAINT			l1ps_lumi_NN 		CHECK ( l1ps_lumi IS NOT NULL),
	CONSTRAINT			l1ps_shift_safe_NN 	CHECK ( l1ps_shift_safe IS NOT NULL),
	CONSTRAINT			l1ps_default_NN 	CHECK ( l1ps_default IS NOT NULL),
	CONSTRAINT			l1ps_val1_NN 		CHECK ( l1ps_val1 IS NOT NULL),
	CONSTRAINT			l1ps_val2_NN 		CHECK ( l1ps_val2 IS NOT NULL),
	CONSTRAINT			l1ps_val3_NN 		CHECK ( l1ps_val3 IS NOT NULL),
	CONSTRAINT			l1ps_val4_NN 		CHECK ( l1ps_val4 IS NOT NULL),
	CONSTRAINT			l1ps_val5_NN 		CHECK ( l1ps_val5 IS NOT NULL),
	CONSTRAINT			l1ps_val6_NN 		CHECK ( l1ps_val6 IS NOT NULL),
	CONSTRAINT			l1ps_val7_NN 		CHECK ( l1ps_val7 IS NOT NULL),
	CONSTRAINT			l1ps_val8_NN 		CHECK ( l1ps_val8 IS NOT NULL),
	CONSTRAINT			l1ps_val9_NN 		CHECK ( l1ps_val9 IS NOT NULL),
	CONSTRAINT			l1ps_val10_NN 		CHECK ( l1ps_val10 IS NOT NULL),
	CONSTRAINT			l1ps_val11_NN 		CHECK ( l1ps_val11 IS NOT NULL),
	CONSTRAINT			l1ps_val12_NN 		CHECK ( l1ps_val12 IS NOT NULL),
	CONSTRAINT			l1ps_val13_NN 		CHECK ( l1ps_val13 IS NOT NULL),
	CONSTRAINT			l1ps_val14_NN 		CHECK ( l1ps_val14 IS NOT NULL),
	CONSTRAINT			l1ps_val15_NN 		CHECK ( l1ps_val15 IS NOT NULL),
	CONSTRAINT			l1ps_val16_NN 		CHECK ( l1ps_val16 IS NOT NULL),
	CONSTRAINT			l1ps_val17_NN 		CHECK ( l1ps_val17 IS NOT NULL),
	CONSTRAINT			l1ps_val18_NN 		CHECK ( l1ps_val18 IS NOT NULL),
	CONSTRAINT			l1ps_val19_NN 		CHECK ( l1ps_val19 IS NOT NULL),
	CONSTRAINT			l1ps_val20_NN 		CHECK ( l1ps_val20 IS NOT NULL),
	CONSTRAINT			l1ps_val21_NN 		CHECK ( l1ps_val21 IS NOT NULL),
	CONSTRAINT			l1ps_val22_NN 		CHECK ( l1ps_val22 IS NOT NULL),
	CONSTRAINT			l1ps_val23_NN 		CHECK ( l1ps_val23 IS NOT NULL),
	CONSTRAINT			l1ps_val24_NN 		CHECK ( l1ps_val24 IS NOT NULL),
	CONSTRAINT			l1ps_val25_NN 		CHECK ( l1ps_val25 IS NOT NULL),
	CONSTRAINT			l1ps_val26_NN 		CHECK ( l1ps_val26 IS NOT NULL),
	CONSTRAINT			l1ps_val27_NN 		CHECK ( l1ps_val27 IS NOT NULL),
	CONSTRAINT			l1ps_val28_NN 		CHECK ( l1ps_val28 IS NOT NULL),
	CONSTRAINT			l1ps_val29_NN 		CHECK ( l1ps_val29 IS NOT NULL),
	CONSTRAINT			l1ps_val30_NN 		CHECK ( l1ps_val30 IS NOT NULL),
	CONSTRAINT			l1ps_val31_NN 		CHECK ( l1ps_val31 IS NOT NULL),
	CONSTRAINT			l1ps_val32_NN 		CHECK ( l1ps_val32 IS NOT NULL),
	CONSTRAINT			l1ps_val33_NN 		CHECK ( l1ps_val33 IS NOT NULL),
	CONSTRAINT			l1ps_val34_NN 		CHECK ( l1ps_val34 IS NOT NULL),
	CONSTRAINT			l1ps_val35_NN 		CHECK ( l1ps_val35 IS NOT NULL),
	CONSTRAINT			l1ps_val36_NN 		CHECK ( l1ps_val36 IS NOT NULL),
	CONSTRAINT			l1ps_val37_NN 		CHECK ( l1ps_val37 IS NOT NULL),
	CONSTRAINT			l1ps_val38_NN 		CHECK ( l1ps_val38 IS NOT NULL),
	CONSTRAINT			l1ps_val39_NN 		CHECK ( l1ps_val39 IS NOT NULL),
	CONSTRAINT			l1ps_val40_NN 		CHECK ( l1ps_val40 IS NOT NULL),
	CONSTRAINT			l1ps_val41_NN 		CHECK ( l1ps_val14 IS NOT NULL),
	CONSTRAINT			l1ps_val42_NN 		CHECK ( l1ps_val42 IS NOT NULL),
	CONSTRAINT			l1ps_val43_NN 		CHECK ( l1ps_val43 IS NOT NULL),
	CONSTRAINT			l1ps_val44_NN 		CHECK ( l1ps_val44 IS NOT NULL),
	CONSTRAINT			l1ps_val45_NN 		CHECK ( l1ps_val45 IS NOT NULL),
	CONSTRAINT			l1ps_val46_NN 		CHECK ( l1ps_val46 IS NOT NULL),
	CONSTRAINT			l1ps_val47_NN 		CHECK ( l1ps_val47 IS NOT NULL),
	CONSTRAINT			l1ps_val48_NN 		CHECK ( l1ps_val48 IS NOT NULL),
	CONSTRAINT			l1ps_val49_NN 		CHECK ( l1ps_val49 IS NOT NULL),
	CONSTRAINT			l1ps_val50_NN 		CHECK ( l1ps_val50 IS NOT NULL),
	CONSTRAINT			l1ps_val51_NN 		CHECK ( l1ps_val51 IS NOT NULL),
	CONSTRAINT			l1ps_val52_NN 		CHECK ( l1ps_val52 IS NOT NULL),
	CONSTRAINT			l1ps_val53_NN 		CHECK ( l1ps_val53 IS NOT NULL),
	CONSTRAINT			l1ps_val54_NN 		CHECK ( l1ps_val54 IS NOT NULL),
	CONSTRAINT			l1ps_val55_NN 		CHECK ( l1ps_val55 IS NOT NULL),
	CONSTRAINT			l1ps_val56_NN 		CHECK ( l1ps_val56 IS NOT NULL),
	CONSTRAINT			l1ps_val57_NN 		CHECK ( l1ps_val57 IS NOT NULL),
	CONSTRAINT			l1ps_val58_NN 		CHECK ( l1ps_val58 IS NOT NULL),
	CONSTRAINT			l1ps_val59_NN 		CHECK ( l1ps_val59 IS NOT NULL),
	CONSTRAINT			l1ps_val60_NN 		CHECK ( l1ps_val60 IS NOT NULL),
	CONSTRAINT			l1ps_val61_NN 		CHECK ( l1ps_val61 IS NOT NULL),
	CONSTRAINT			l1ps_val62_NN 		CHECK ( l1ps_val62 IS NOT NULL),
	CONSTRAINT			l1ps_val63_NN 		CHECK ( l1ps_val63 IS NOT NULL),
	CONSTRAINT			l1ps_val64_NN 		CHECK ( l1ps_val64 IS NOT NULL),
	CONSTRAINT			l1ps_val65_NN 		CHECK ( l1ps_val65 IS NOT NULL),
	CONSTRAINT			l1ps_val66_NN 		CHECK ( l1ps_val66 IS NOT NULL),
	CONSTRAINT			l1ps_val67_NN 		CHECK ( l1ps_val67 IS NOT NULL),
	CONSTRAINT			l1ps_val68_NN 		CHECK ( l1ps_val68 IS NOT NULL),
	CONSTRAINT			l1ps_val69_NN 		CHECK ( l1ps_val69 IS NOT NULL),
	CONSTRAINT			l1ps_val70_NN 		CHECK ( l1ps_val70 IS NOT NULL),
	CONSTRAINT			l1ps_val71_NN 		CHECK ( l1ps_val71 IS NOT NULL),
	CONSTRAINT			l1ps_val72_NN 		CHECK ( l1ps_val72 IS NOT NULL),
	CONSTRAINT			l1ps_val73_NN 		CHECK ( l1ps_val73 IS NOT NULL),
	CONSTRAINT			l1ps_val74_NN 		CHECK ( l1ps_val74 IS NOT NULL),
	CONSTRAINT			l1ps_val75_NN 		CHECK ( l1ps_val75 IS NOT NULL),
	CONSTRAINT			l1ps_val76_NN 		CHECK ( l1ps_val76 IS NOT NULL),
	CONSTRAINT			l1ps_val77_NN 		CHECK ( l1ps_val77 IS NOT NULL),
	CONSTRAINT			l1ps_val78_NN 		CHECK ( l1ps_val78 IS NOT NULL),
	CONSTRAINT			l1ps_val79_NN 		CHECK ( l1ps_val79 IS NOT NULL),
	CONSTRAINT			l1ps_val80_NN 		CHECK ( l1ps_val80 IS NOT NULL),
	CONSTRAINT			l1ps_val81_NN 		CHECK ( l1ps_val81 IS NOT NULL),
	CONSTRAINT			l1ps_val82_NN 		CHECK ( l1ps_val82 IS NOT NULL),
	CONSTRAINT			l1ps_val83_NN 		CHECK ( l1ps_val83 IS NOT NULL),
	CONSTRAINT			l1ps_val84_NN 		CHECK ( l1ps_val84 IS NOT NULL),
	CONSTRAINT			l1ps_val85_NN 		CHECK ( l1ps_val85 IS NOT NULL),
	CONSTRAINT			l1ps_val86_NN 		CHECK ( l1ps_val86 IS NOT NULL),
	CONSTRAINT			l1ps_val87_NN 		CHECK ( l1ps_val87 IS NOT NULL),
	CONSTRAINT			l1ps_val88_NN 		CHECK ( l1ps_val88 IS NOT NULL),
	CONSTRAINT			l1ps_val89_NN 		CHECK ( l1ps_val89 IS NOT NULL),
	CONSTRAINT			l1ps_val90_NN 		CHECK ( l1ps_val90 IS NOT NULL),
	CONSTRAINT			l1ps_val91_NN 		CHECK ( l1ps_val91 IS NOT NULL),
	CONSTRAINT			l1ps_val92_NN 		CHECK ( l1ps_val92 IS NOT NULL),
	CONSTRAINT			l1ps_val93_NN 		CHECK ( l1ps_val93 IS NOT NULL),
	CONSTRAINT			l1ps_val94_NN 		CHECK ( l1ps_val94 IS NOT NULL),
	CONSTRAINT			l1ps_val95_NN 		CHECK ( l1ps_val95 IS NOT NULL),
	CONSTRAINT			l1ps_val96_NN 		CHECK ( l1ps_val96 IS NOT NULL),
	CONSTRAINT			l1ps_val97_NN 		CHECK ( l1ps_val97 IS NOT NULL),
	CONSTRAINT			l1ps_val98_NN 		CHECK ( l1ps_val98 IS NOT NULL),
	CONSTRAINT			l1ps_val99_NN 		CHECK ( l1ps_val99 IS NOT NULL),
	CONSTRAINT			l1ps_val100_NN 		CHECK ( l1ps_val100 IS NOT NULL),
	CONSTRAINT			l1ps_val101_NN 		CHECK ( l1ps_val101 IS NOT NULL),
	CONSTRAINT			l1ps_val102_NN 		CHECK ( l1ps_val102 IS NOT NULL),
	CONSTRAINT			l1ps_val103_NN 		CHECK ( l1ps_val103 IS NOT NULL),
	CONSTRAINT			l1ps_val104_NN 		CHECK ( l1ps_val104 IS NOT NULL),
	CONSTRAINT			l1ps_val105_NN 		CHECK ( l1ps_val105 IS NOT NULL),
	CONSTRAINT			l1ps_val106_NN 		CHECK ( l1ps_val106 IS NOT NULL),
	CONSTRAINT			l1ps_val107_NN 		CHECK ( l1ps_val107 IS NOT NULL),
	CONSTRAINT			l1ps_val108_NN 		CHECK ( l1ps_val108 IS NOT NULL),
	CONSTRAINT			l1ps_val109_NN 		CHECK ( l1ps_val109 IS NOT NULL),
	CONSTRAINT			l1ps_val110_NN 		CHECK ( l1ps_val110 IS NOT NULL),
	CONSTRAINT			l1ps_val111_NN 		CHECK ( l1ps_val111 IS NOT NULL),
	CONSTRAINT			l1ps_val112_NN 		CHECK ( l1ps_val112 IS NOT NULL),
	CONSTRAINT			l1ps_val113_NN 		CHECK ( l1ps_val113 IS NOT NULL),
	CONSTRAINT			l1ps_val114_NN 		CHECK ( l1ps_val114 IS NOT NULL),
	CONSTRAINT			l1ps_val115_NN 		CHECK ( l1ps_val115 IS NOT NULL),
	CONSTRAINT			l1ps_val116_NN 		CHECK ( l1ps_val116 IS NOT NULL),
	CONSTRAINT			l1ps_val117_NN 		CHECK ( l1ps_val117 IS NOT NULL),
	CONSTRAINT			l1ps_val118_NN 		CHECK ( l1ps_val118 IS NOT NULL),
	CONSTRAINT			l1ps_val119_NN 		CHECK ( l1ps_val119 IS NOT NULL),
	CONSTRAINT			l1ps_val120_NN 		CHECK ( l1ps_val120 IS NOT NULL),
	CONSTRAINT			l1ps_val121_NN 		CHECK ( l1ps_val121 IS NOT NULL),
	CONSTRAINT			l1ps_val122_NN 		CHECK ( l1ps_val122 IS NOT NULL),
	CONSTRAINT			l1ps_val123_NN 		CHECK ( l1ps_val123 IS NOT NULL),
	CONSTRAINT			l1ps_val124_NN 		CHECK ( l1ps_val124 IS NOT NULL),
	CONSTRAINT			l1ps_val125_NN 		CHECK ( l1ps_val125 IS NOT NULL),
	CONSTRAINT			l1ps_val126_NN 		CHECK ( l1ps_val126 IS NOT NULL),
	CONSTRAINT			l1ps_val127_NN 		CHECK ( l1ps_val127 IS NOT NULL),
	CONSTRAINT			l1ps_val128_NN 		CHECK ( l1ps_val128 IS NOT NULL),
	CONSTRAINT			l1ps_val129_NN 		CHECK ( l1ps_val129 IS NOT NULL),
	CONSTRAINT			l1ps_val130_NN 		CHECK ( l1ps_val130 IS NOT NULL),
	CONSTRAINT			l1ps_val131_NN 		CHECK ( l1ps_val131 IS NOT NULL),
	CONSTRAINT			l1ps_val132_NN 		CHECK ( l1ps_val132 IS NOT NULL),
	CONSTRAINT			l1ps_val133_NN 		CHECK ( l1ps_val133 IS NOT NULL),
	CONSTRAINT			l1ps_val134_NN 		CHECK ( l1ps_val134 IS NOT NULL),
	CONSTRAINT			l1ps_val135_NN 		CHECK ( l1ps_val135 IS NOT NULL),
	CONSTRAINT			l1ps_val136_NN 		CHECK ( l1ps_val136 IS NOT NULL),
	CONSTRAINT			l1ps_val137_NN 		CHECK ( l1ps_val137 IS NOT NULL),
	CONSTRAINT			l1ps_val138_NN 		CHECK ( l1ps_val138 IS NOT NULL),
	CONSTRAINT			l1ps_val139_NN 		CHECK ( l1ps_val139 IS NOT NULL),
	CONSTRAINT			l1ps_val140_NN 		CHECK ( l1ps_val140 IS NOT NULL),
	CONSTRAINT			l1ps_val141_NN 		CHECK ( l1ps_val114 IS NOT NULL),
	CONSTRAINT			l1ps_val142_NN 		CHECK ( l1ps_val142 IS NOT NULL),
	CONSTRAINT			l1ps_val143_NN 		CHECK ( l1ps_val143 IS NOT NULL),
	CONSTRAINT			l1ps_val144_NN 		CHECK ( l1ps_val144 IS NOT NULL),
	CONSTRAINT			l1ps_val145_NN 		CHECK ( l1ps_val145 IS NOT NULL),
	CONSTRAINT			l1ps_val146_NN 		CHECK ( l1ps_val146 IS NOT NULL),
	CONSTRAINT			l1ps_val147_NN 		CHECK ( l1ps_val147 IS NOT NULL),
	CONSTRAINT			l1ps_val148_NN 		CHECK ( l1ps_val148 IS NOT NULL),
	CONSTRAINT			l1ps_val149_NN 		CHECK ( l1ps_val149 IS NOT NULL),
	CONSTRAINT			l1ps_val150_NN 		CHECK ( l1ps_val150 IS NOT NULL),
	CONSTRAINT			l1ps_val151_NN 		CHECK ( l1ps_val151 IS NOT NULL),
	CONSTRAINT			l1ps_val152_NN 		CHECK ( l1ps_val152 IS NOT NULL),
	CONSTRAINT			l1ps_val153_NN 		CHECK ( l1ps_val153 IS NOT NULL),
	CONSTRAINT			l1ps_val154_NN 		CHECK ( l1ps_val154 IS NOT NULL),
	CONSTRAINT			l1ps_val155_NN 		CHECK ( l1ps_val155 IS NOT NULL),
	CONSTRAINT			l1ps_val156_NN 		CHECK ( l1ps_val156 IS NOT NULL),
	CONSTRAINT			l1ps_val157_NN 		CHECK ( l1ps_val157 IS NOT NULL),
	CONSTRAINT			l1ps_val158_NN 		CHECK ( l1ps_val158 IS NOT NULL),
	CONSTRAINT			l1ps_val159_NN 		CHECK ( l1ps_val159 IS NOT NULL),
	CONSTRAINT			l1ps_val160_NN 		CHECK ( l1ps_val160 IS NOT NULL),
	CONSTRAINT			l1ps_val161_NN 		CHECK ( l1ps_val161 IS NOT NULL),
	CONSTRAINT			l1ps_val162_NN 		CHECK ( l1ps_val162 IS NOT NULL),
	CONSTRAINT			l1ps_val163_NN 		CHECK ( l1ps_val163 IS NOT NULL),
	CONSTRAINT			l1ps_val164_NN 		CHECK ( l1ps_val164 IS NOT NULL),
	CONSTRAINT			l1ps_val165_NN 		CHECK ( l1ps_val165 IS NOT NULL),
	CONSTRAINT			l1ps_val166_NN 		CHECK ( l1ps_val166 IS NOT NULL),
	CONSTRAINT			l1ps_val167_NN 		CHECK ( l1ps_val167 IS NOT NULL),
	CONSTRAINT			l1ps_val168_NN 		CHECK ( l1ps_val168 IS NOT NULL),
	CONSTRAINT			l1ps_val169_NN 		CHECK ( l1ps_val169 IS NOT NULL),
	CONSTRAINT			l1ps_val170_NN 		CHECK ( l1ps_val170 IS NOT NULL),
	CONSTRAINT			l1ps_val171_NN 		CHECK ( l1ps_val171 IS NOT NULL),
	CONSTRAINT			l1ps_val172_NN 		CHECK ( l1ps_val172 IS NOT NULL),
	CONSTRAINT			l1ps_val173_NN 		CHECK ( l1ps_val173 IS NOT NULL),
	CONSTRAINT			l1ps_val174_NN 		CHECK ( l1ps_val174 IS NOT NULL),
	CONSTRAINT			l1ps_val175_NN 		CHECK ( l1ps_val175 IS NOT NULL),
	CONSTRAINT			l1ps_val176_NN 		CHECK ( l1ps_val176 IS NOT NULL),
	CONSTRAINT			l1ps_val177_NN 		CHECK ( l1ps_val177 IS NOT NULL),
	CONSTRAINT			l1ps_val178_NN 		CHECK ( l1ps_val178 IS NOT NULL),
	CONSTRAINT			l1ps_val179_NN 		CHECK ( l1ps_val179 IS NOT NULL),
	CONSTRAINT			l1ps_val180_NN 		CHECK ( l1ps_val180 IS NOT NULL),
	CONSTRAINT			l1ps_val181_NN 		CHECK ( l1ps_val181 IS NOT NULL),
	CONSTRAINT			l1ps_val182_NN 		CHECK ( l1ps_val182 IS NOT NULL),
	CONSTRAINT			l1ps_val183_NN 		CHECK ( l1ps_val183 IS NOT NULL),
	CONSTRAINT			l1ps_val184_NN 		CHECK ( l1ps_val184 IS NOT NULL),
	CONSTRAINT			l1ps_val185_NN 		CHECK ( l1ps_val185 IS NOT NULL),
	CONSTRAINT			l1ps_val186_NN 		CHECK ( l1ps_val186 IS NOT NULL),
	CONSTRAINT			l1ps_val187_NN 		CHECK ( l1ps_val187 IS NOT NULL),
	CONSTRAINT			l1ps_val188_NN 		CHECK ( l1ps_val188 IS NOT NULL),
	CONSTRAINT			l1ps_val189_NN 		CHECK ( l1ps_val189 IS NOT NULL),
	CONSTRAINT			l1ps_val190_NN 		CHECK ( l1ps_val190 IS NOT NULL),
	CONSTRAINT			l1ps_val191_NN 		CHECK ( l1ps_val191 IS NOT NULL),
	CONSTRAINT			l1ps_val192_NN 		CHECK ( l1ps_val192 IS NOT NULL),
	CONSTRAINT			l1ps_val193_NN 		CHECK ( l1ps_val193 IS NOT NULL),
	CONSTRAINT			l1ps_val194_NN 		CHECK ( l1ps_val194 IS NOT NULL),
	CONSTRAINT			l1ps_val195_NN 		CHECK ( l1ps_val195 IS NOT NULL),
	CONSTRAINT			l1ps_val196_NN 		CHECK ( l1ps_val196 IS NOT NULL),
	CONSTRAINT			l1ps_val197_NN 		CHECK ( l1ps_val197 IS NOT NULL),
	CONSTRAINT			l1ps_val198_NN 		CHECK ( l1ps_val198 IS NOT NULL),
	CONSTRAINT			l1ps_val199_NN 		CHECK ( l1ps_val199 IS NOT NULL),
	CONSTRAINT			l1ps_val200_NN 		CHECK ( l1ps_val200 IS NOT NULL),
	CONSTRAINT			l1ps_val201_NN 		CHECK ( l1ps_val201 IS NOT NULL),
	CONSTRAINT			l1ps_val202_NN 		CHECK ( l1ps_val202 IS NOT NULL),
	CONSTRAINT			l1ps_val203_NN 		CHECK ( l1ps_val203 IS NOT NULL),
	CONSTRAINT			l1ps_val204_NN 		CHECK ( l1ps_val204 IS NOT NULL),
	CONSTRAINT			l1ps_val205_NN 		CHECK ( l1ps_val205 IS NOT NULL),
	CONSTRAINT			l1ps_val206_NN 		CHECK ( l1ps_val206 IS NOT NULL),
	CONSTRAINT			l1ps_val207_NN 		CHECK ( l1ps_val207 IS NOT NULL),
	CONSTRAINT			l1ps_val208_NN 		CHECK ( l1ps_val208 IS NOT NULL),
	CONSTRAINT			l1ps_val209_NN 		CHECK ( l1ps_val209 IS NOT NULL),
	CONSTRAINT			l1ps_val210_NN 		CHECK ( l1ps_val210 IS NOT NULL),
	CONSTRAINT			l1ps_val211_NN 		CHECK ( l1ps_val211 IS NOT NULL),
	CONSTRAINT			l1ps_val212_NN 		CHECK ( l1ps_val212 IS NOT NULL),
	CONSTRAINT			l1ps_val213_NN 		CHECK ( l1ps_val213 IS NOT NULL),
	CONSTRAINT			l1ps_val214_NN 		CHECK ( l1ps_val214 IS NOT NULL),
	CONSTRAINT			l1ps_val215_NN 		CHECK ( l1ps_val215 IS NOT NULL),
	CONSTRAINT			l1ps_val216_NN 		CHECK ( l1ps_val216 IS NOT NULL),
	CONSTRAINT			l1ps_val217_NN 		CHECK ( l1ps_val217 IS NOT NULL),
	CONSTRAINT			l1ps_val218_NN 		CHECK ( l1ps_val218 IS NOT NULL),
	CONSTRAINT			l1ps_val219_NN 		CHECK ( l1ps_val219 IS NOT NULL),
	CONSTRAINT			l1ps_val220_NN 		CHECK ( l1ps_val220 IS NOT NULL),
	CONSTRAINT			l1ps_val221_NN 		CHECK ( l1ps_val221 IS NOT NULL),
	CONSTRAINT			l1ps_val222_NN 		CHECK ( l1ps_val222 IS NOT NULL),
	CONSTRAINT			l1ps_val223_NN 		CHECK ( l1ps_val223 IS NOT NULL),
	CONSTRAINT			l1ps_val224_NN 		CHECK ( l1ps_val224 IS NOT NULL),
	CONSTRAINT			l1ps_val225_NN 		CHECK ( l1ps_val225 IS NOT NULL),
	CONSTRAINT			l1ps_val226_NN 		CHECK ( l1ps_val226 IS NOT NULL),
	CONSTRAINT			l1ps_val227_NN 		CHECK ( l1ps_val227 IS NOT NULL),
	CONSTRAINT			l1ps_val228_NN 		CHECK ( l1ps_val228 IS NOT NULL),
	CONSTRAINT			l1ps_val229_NN 		CHECK ( l1ps_val229 IS NOT NULL),
	CONSTRAINT			l1ps_val230_NN 		CHECK ( l1ps_val230 IS NOT NULL),
	CONSTRAINT			l1ps_val231_NN 		CHECK ( l1ps_val231 IS NOT NULL),
	CONSTRAINT			l1ps_val232_NN 		CHECK ( l1ps_val232 IS NOT NULL),
	CONSTRAINT			l1ps_val233_NN 		CHECK ( l1ps_val233 IS NOT NULL),
	CONSTRAINT			l1ps_val234_NN 		CHECK ( l1ps_val234 IS NOT NULL),
	CONSTRAINT			l1ps_val235_NN 		CHECK ( l1ps_val235 IS NOT NULL),
	CONSTRAINT			l1ps_val236_NN 		CHECK ( l1ps_val236 IS NOT NULL),
	CONSTRAINT			l1ps_val237_NN 		CHECK ( l1ps_val237 IS NOT NULL),
	CONSTRAINT			l1ps_val238_NN 		CHECK ( l1ps_val238 IS NOT NULL),
	CONSTRAINT			l1ps_val239_NN 		CHECK ( l1ps_val239 IS NOT NULL),
	CONSTRAINT			l1ps_val240_NN 		CHECK ( l1ps_val240 IS NOT NULL),
	CONSTRAINT			l1ps_val241_NN 		CHECK ( l1ps_val241 IS NOT NULL),
	CONSTRAINT			l1ps_val242_NN 		CHECK ( l1ps_val242 IS NOT NULL),
	CONSTRAINT			l1ps_val243_NN 		CHECK ( l1ps_val243 IS NOT NULL),
	CONSTRAINT			l1ps_val244_NN 		CHECK ( l1ps_val244 IS NOT NULL),
	CONSTRAINT			l1ps_val245_NN 		CHECK ( l1ps_val245 IS NOT NULL),
	CONSTRAINT			l1ps_val246_NN 		CHECK ( l1ps_val246 IS NOT NULL),
	CONSTRAINT			l1ps_val247_NN 		CHECK ( l1ps_val247 IS NOT NULL),
	CONSTRAINT			l1ps_val248_NN 		CHECK ( l1ps_val248 IS NOT NULL),
	CONSTRAINT			l1ps_val249_NN 		CHECK ( l1ps_val249 IS NOT NULL),
	CONSTRAINT			l1ps_val250_NN 		CHECK ( l1ps_val250 IS NOT NULL),
	CONSTRAINT			l1ps_val251_NN 		CHECK ( l1ps_val251 IS NOT NULL),
	CONSTRAINT			l1ps_val252_NN 		CHECK ( l1ps_val252 IS NOT NULL),
	CONSTRAINT			l1ps_val253_NN 		CHECK ( l1ps_val253 IS NOT NULL),
	CONSTRAINT			l1ps_val254_NN 		CHECK ( l1ps_val254 IS NOT NULL),
	CONSTRAINT			l1ps_val255_NN 		CHECK ( l1ps_val255 IS NOT NULL),
	CONSTRAINT			l1ps_val256_NN 		CHECK ( l1ps_val256 IS NOT NULL),
	CONSTRAINT			l1ps_used_NN 		CHECK ( l1ps_used IS NOT NULL)
);


---------------------------
-- N to N relationships --
--------------------------

-- Menu and prescale relation
CREATE TABLE l1_tm_to_ps ( 
	l1tm2ps_id 			NUMBER(10),	
	l1tm2ps_trigger_menu_id 	NUMBER(10),	
	l1tm2ps_prescale_set_id 	NUMBER(10),	
	l1tm2ps_username 		VARCHAR2(50),
	l1tm2ps_modified_time		TIMESTAMP,	
	l1tm2ps_used			CHAR			default 0,
	CONSTRAINT			l1tm2ps_pk		PRIMARY KEY (l1tm2ps_id),
	CONSTRAINT			l1tm2ps_fk_tm		FOREIGN KEY (l1tm2ps_trigger_menu_id)
								REFERENCES l1_trigger_menu(l1tm_id),
	CONSTRAINT			l1tm2ps_fk_ps 		FOREIGN KEY (l1tm2ps_prescale_set_id)
								REFERENCES l1_prescale_set(l1ps_id),
	CONSTRAINT			l1tm2ps_id_NN 		CHECK ( l1tm2ps_id IS NOT NULL),
	CONSTRAINT			l1tm2ps_menu_id_NN 	CHECK ( l1tm2ps_trigger_menu_id IS NOT NULL),
	CONSTRAINT			l1tm2ps_pss_id_NN 	CHECK ( l1tm2ps_prescale_set_id IS NOT NULL),
	CONSTRAINT			l1tm2ps_used_NN 	CHECK ( l1tm2ps_used IS NOT NULL)
);
CREATE INDEX l1tm2ps_trigger_menu_id_ind ON l1_tm_to_ps(l1tm2ps_trigger_menu_id);
CREATE INDEX l1tm2ps_prescale_set_id_ind ON l1_tm_to_ps(l1tm2ps_prescale_set_id);

-- this table encodes the n-n relationship between trigger
-- menu and trigger items. The ti_ctp_id is needed to associate
-- the correct prescale factor from the presclae factor set with the trigger
-- item.
CREATE TABLE l1_tm_to_ti ( 
	l1tm2ti_id 			NUMBER(10),
	l1tm2ti_trigger_menu_id 	NUMBER(10),
	l1tm2ti_trigger_item_id 	NUMBER(10),
	l1tm2ti_username 		VARCHAR2(50),
	l1tm2ti_modified_time		TIMESTAMP,
	l1tm2ti_used			CHAR			default 0,
	CONSTRAINT			l1tm2ti_pk		PRIMARY KEY (l1tm2ti_id),
	CONSTRAINT			l1tm2ti_fk_tm		FOREIGN KEY (l1tm2ti_trigger_menu_id) 
								REFERENCES l1_trigger_menu(l1tm_id),
	CONSTRAINT			l1tm2ti_fk_ti 		FOREIGN KEY (l1tm2ti_trigger_item_id) 
								REFERENCES l1_trigger_item(l1ti_id),
	CONSTRAINT			l1tm2ti_id_NN 		CHECK ( l1tm2ti_id IS NOT NULL),
	CONSTRAINT			l1tm2ti_trigger_menu_id_NN 		CHECK ( l1tm2ti_trigger_menu_id IS NOT NULL),
	CONSTRAINT			l1tm2ti_trigger_item_id_NN 		CHECK ( l1tm2ti_trigger_item_id IS NOT NULL),
	CONSTRAINT			l1tm2ti_used_NN 	CHECK ( l1tm2ti_used IS NOT NULL)
);
CREATE INDEX l1tm2ti_trigger_menu_id_ind ON l1_tm_to_ti(l1tm2ti_trigger_menu_id);
CREATE INDEX l1tm2ti_trigger_item_id_ind ON l1_tm_to_ti(l1tm2ti_trigger_item_id);

-- here the n-n relationship between trigger item and trigger threshold is
-- encoded. the ti_tt_position and ti_tt_multiplicity are needed for
-- complicated logic structures. ti_tt_position gives the position of the
-- threshold inside of the logical expression defined in the ti_definition
-- of the references trigger item. ti_tt_multiplicity is just the requied 
-- multiplicity.
CREATE TABLE l1_ti_to_tt ( 
	l1ti2tt_id 			NUMBER(10),
	l1ti2tt_trigger_item_id 	NUMBER(10),
	l1ti2tt_trigger_threshold_id 	NUMBER(10),
	l1ti2tt_position		NUMBER(10),
	l1ti2tt_multiplicity		NUMBER(10),
	l1ti2tt_username 		VARCHAR2(50),
	l1ti2tt_modified_time		TIMESTAMP,
	l1ti2tt_used			CHAR			default 0,
	CONSTRAINT			l1ti2tt_pk		PRIMARY KEY (l1ti2tt_id),
	CONSTRAINT			l1ti2tt_fk_ti		FOREIGN KEY (l1ti2tt_trigger_item_id) 
								REFERENCES l1_trigger_item(l1ti_id),
	CONSTRAINT			l1ti2tt_fk_tt		FOREIGN KEY (l1ti2tt_trigger_threshold_id)
								REFERENCES l1_trigger_threshold(l1tt_id),
	CONSTRAINT			l1ti2tt_id_NN 		CHECK ( l1ti2tt_id IS NOT NULL),
	CONSTRAINT			l1ti2tt_item_id_NN 	CHECK ( l1ti2tt_trigger_item_id IS NOT NULL),
	CONSTRAINT			l1ti2tt_thres_id_NN 	CHECK ( l1ti2tt_trigger_threshold_id IS NOT NULL),
	CONSTRAINT			l1ti2tt_position_NN 	CHECK ( l1ti2tt_position IS NOT NULL),
	CONSTRAINT			l1ti2tt_multiplicity_NN CHECK ( l1ti2tt_multiplicity IS NOT NULL),
	CONSTRAINT			l1ti2tt_used_NN 	CHECK ( l1ti2tt_used IS NOT NULL)
);
CREATE INDEX l1ti2tt_trigger_item_id_ind  ON l1_ti_to_tt(l1ti2tt_trigger_item_id);
CREATE INDEX l1ti2tt_trigger_thres_id_ind ON l1_ti_to_tt(l1ti2tt_trigger_threshold_id);

-- n-n relationship between trigger threshold and trigger threshold value.
CREATE TABLE l1_tt_to_ttv (
	l1tt2ttv_id 			NUMBER(10), 	
	l1tt2ttv_trigger_threshold_id 	NUMBER(10), 	
	l1tt2ttv_trig_thres_value_id 	NUMBER(10), 	
	l1tt2ttv_username 		VARCHAR2(50),	
	l1tt2ttv_modified_time		TIMESTAMP,	
	l1tt2ttv_used			CHAR			default 0,
	CONSTRAINT			l1tt2ttv_pk		PRIMARY KEY (l1tt2ttv_id),
	CONSTRAINT			l1tt2ttv_fk_tt		FOREIGN KEY (l1tt2ttv_trigger_threshold_id)
								REFERENCES l1_trigger_threshold(l1tt_id),
	CONSTRAINT			l1tt2ttv_fk_ttv		FOREIGN KEY (l1tt2ttv_trig_thres_value_id)
								REFERENCES l1_trigger_threshold_value(l1ttv_id),
	CONSTRAINT			l1tt2ttv_id_NN 		CHECK ( l1tt2ttv_id IS NOT NULL),
	CONSTRAINT			l1tt2ttv_thres_id_NN	CHECK ( l1tt2ttv_trigger_threshold_id IS NOT NULL),
	CONSTRAINT			l1tt2ttv_thres_va_id_NN CHECK ( l1tt2ttv_trig_thres_value_id IS NOT NULL),
	CONSTRAINT			l1tt2ttv_used_NN 	CHECK ( l1tt2ttv_used IS NOT NULL)
);
CREATE INDEX l1tt2ttv_trigger_thres_id_ind  ON l1_tt_to_ttv(l1tt2ttv_trigger_threshold_id);
CREATE INDEX l1tt2ttv_trig_thres_val_id_ind ON l1_tt_to_ttv(l1tt2ttv_trig_thres_value_id);

-- This table list all thresholds of a menu that is included in the menu
-- by hand, ie. which are not part of the menu via items. 
CREATE TABLE l1_tm_to_tt_forced ( 
	l1tm2ttf_id 			NUMBER(10), 
	l1tm2ttf_trigger_menu_id 	NUMBER(10), 
	l1tm2ttf_trigger_threshold_id 	NUMBER(10), 
	l1tm2ttf_username 		VARCHAR2(50),
	l1tm2ttf_modified_time		TIMESTAMP,
	l1tm2ttf_used			CHAR			default 0,
	CONSTRAINT			l1tm2ttf_pk		PRIMARY KEY (l1tm2ttf_id),
	CONSTRAINT			l1tm2ttf_fk_tm		FOREIGN KEY (l1tm2ttf_trigger_menu_id) 
								REFERENCES l1_trigger_menu(l1tm_id),
	CONSTRAINT			l1tm2ttf_fk_tt		FOREIGN KEY (l1tm2ttf_trigger_threshold_id)
								REFERENCES l1_trigger_threshold(l1tt_id),
	CONSTRAINT			l1tm2ttf_id_NN 		CHECK ( l1tm2ttf_id IS NOT NULL),
	CONSTRAINT			l1tm2ttf_menu_id_NN	CHECK ( l1tm2ttf_trigger_menu_id IS NOT NULL),
	CONSTRAINT			l1tm2ttf_thres_id_NN 	CHECK ( l1tm2ttf_trigger_threshold_id IS NOT NULL),
	CONSTRAINT			l1tm2ttf_used_NN 	CHECK ( l1tm2ttf_used IS NOT NULL)
);
CREATE INDEX l1tm2ttf_trigger_menu_id_ind ON l1_tm_to_tt_forced(l1tm2ttf_trigger_menu_id);
CREATE INDEX l1tm2ttf_trigger_thresid_ind ON l1_tm_to_tt_forced(l1tm2ttf_trigger_threshold_id);

-- This table is needed to store the information on which cable
-- the thresholds are delivered to the CTP. This information depends
-- on the thresholds and on the trigger menu (i.e. which other thresholds
-- are present in that trigger menu). The thresholds of a menu can be found via the
-- l1_tm_to_ti and via the l1_tm_to_tt_forced tables. Therefore the information in this table 
-- (i.e. l1_tm_to_tt) must be compiled from l1_tm_to_ti and from the
-- l1_tm_to_tt_forced table. It introduces some data redundancy. 
CREATE TABLE l1_tm_to_tt ( 
	l1tm2tt_id 			NUMBER(10), 	
	l1tm2tt_trigger_menu_id 	NUMBER(10), 	
	l1tm2tt_trigger_threshold_id 	NUMBER(10), 	
	l1tm2tt_cable_name		VARCHAR2(5),	
	l1tm2tt_cable_ctpin		VARCHAR2(5),	
	l1tm2tt_cable_connector		VARCHAR2(5),	
	l1tm2tt_cable_start		NUMBER(10),	
	l1tm2tt_cable_end		NUMBER(10),	
	l1tm2tt_username 		VARCHAR2(50),
	l1tm2tt_modified_time		TIMESTAMP,
	l1tm2tt_used			CHAR			default 0,
	CONSTRAINT			l1tm2tt_pk		PRIMARY KEY (l1tm2tt_id),
	CONSTRAINT			l1tm2tt_fk_tm		FOREIGN KEY (l1tm2tt_trigger_menu_id) 
								REFERENCES l1_trigger_menu(l1tm_id),
	CONSTRAINT			l1tm2tt_fk_tt		FOREIGN KEY (l1tm2tt_trigger_threshold_id)
								REFERENCES l1_trigger_threshold(l1tt_id),
	CONSTRAINT			l1tm2tt_id_NN 		CHECK ( l1tm2tt_id IS NOT NULL),
	CONSTRAINT			l1tm2tt_menu_id_NN	CHECK ( l1tm2tt_trigger_menu_id IS NOT NULL),
	CONSTRAINT			l1tm2tt_thres_id_NN 	CHECK ( l1tm2tt_trigger_threshold_id IS NOT NULL),
	CONSTRAINT			l1tm2tt_cable_name_NN 	CHECK ( l1tm2tt_cable_name IS NOT NULL),
	CONSTRAINT			l1tm2tt_cable_ctpin_NN 	CHECK ( l1tm2tt_trigger_threshold_id IS NOT NULL),
	CONSTRAINT			l1tm2tt_cable_conn_NN 	CHECK ( l1tm2tt_cable_connector IS NOT NULL),
	CONSTRAINT			l1tm2tt_cable_start_NN 	CHECK ( l1tm2tt_cable_start IS NOT NULL),
	CONSTRAINT			l1tm2tt_cable_end_NN 	CHECK ( l1tm2tt_cable_end IS NOT NULL),
	CONSTRAINT			l1tm2tt_used_NN 	CHECK ( l1tm2tt_used IS NOT NULL)
);
CREATE INDEX l1tm2tt_trigger_menu_id_ind  ON l1_tm_to_tt(l1tm2tt_trigger_menu_id);
CREATE INDEX l1tm2tt_trigger_thres_id_ind ON l1_tm_to_tt(l1tm2tt_trigger_threshold_id);

-- hold the l1 pit information
CREATE TABLE l1_pits (
	l1pit_id			NUMBER(10), 	
        l1pit_tm_to_tt_id        	NUMBER(10), 
        l1pit_pit_number         	NUMBER(10), 
        l1pit_threshold_bit      	NUMBER(2),  
	l1pit_username 			VARCHAR2(50),
	l1pit_modified_time		TIMESTAMP,
	l1pit_used			CHAR			default 0,
	CONSTRAINT			l1pit_pk		PRIMARY KEY (l1pit_id),
        CONSTRAINT       	 	l1pit_tm_to_tt_id_fk    FOREIGN KEY (l1pit_tm_to_tt_id)
                       		 				REFERENCES  l1_tm_to_tt(l1tm2tt_id),
	CONSTRAINT			l1pit_id_NN 		CHECK ( l1pit_id IS NOT NULL),
	CONSTRAINT			l1pit_tm_to_tt_id_NN 	CHECK ( l1pit_tm_to_tt_id IS NOT NULL),
	CONSTRAINT			l1pit_pit_number_NN 	CHECK ( l1pit_pit_number IS NOT NULL),
	CONSTRAINT			l1pit_threshold_bit_NN 	CHECK ( l1pit_threshold_bit IS NOT NULL),
	CONSTRAINT			l1pit_used_NN 		CHECK ( l1pit_used IS NOT NULL)
);
CREATE INDEX l1pit_tm_to_tt_id_ind ON l1_pits(l1pit_tm_to_tt_id);

--Monitoring
CREATE TABLE l1_tm_to_tt_mon (
	l1tm2ttm_id 			NUMBER(10),
	l1tm2ttm_trigger_menu_id 	NUMBER(10),
	l1tm2ttm_trigger_threshold_id 	NUMBER(10),
	l1tm2ttm_name			VARCHAR2(50),
	l1tm2ttm_internal_counter	NUMBER(3),
	l1tm2ttm_bunch_group_id		NUMBER(10),
	l1tm2ttm_counter_type		VARCHAR2(10),
	l1tm2ttm_multiplicity		NUMBER(3),
	l1tm2ttm_username 		VARCHAR2(50),
	l1tm2ttm_modified_time		TIMESTAMP,
	l1tm2ttm_used			CHAR			default 0,
	CONSTRAINT			l1tm2ttm_pk		PRIMARY KEY (l1tm2ttm_id),
	CONSTRAINT			l1tm2ttm_fk_tm		FOREIGN KEY (l1tm2ttm_trigger_menu_id) 
								REFERENCES l1_trigger_menu(l1tm_id),
	CONSTRAINT			l1tm2ttm_fk_tt		FOREIGN KEY (l1tm2ttm_trigger_threshold_id)
								REFERENCES l1_trigger_threshold(l1tt_id),
	CONSTRAINT			l1tm2ttm_id_NN 		CHECK ( l1tm2ttm_id IS NOT NULL),
	CONSTRAINT			l1tm2ttm_menu_id_NN	CHECK ( l1tm2ttm_trigger_menu_id IS NOT NULL),
	CONSTRAINT			l1tm2ttm_thres_id_NN 	CHECK ( l1tm2ttm_trigger_threshold_id IS NOT NULL),
	CONSTRAINT			l1tm2ttm_name_NN 	CHECK ( l1tm2ttm_name IS NOT NULL),
	CONSTRAINT			l1tm2ttm_int_counter_NN CHECK ( l1tm2ttm_internal_counter IS NOT NULL),
	CONSTRAINT			l1tm2ttm_bch_grp_id_NN 	CHECK ( l1tm2ttm_bunch_group_id IS NOT NULL),
	CONSTRAINT			l1tm2ttm_cter_type_NN 	CHECK ( l1tm2ttm_counter_type IS NOT NULL),
	CONSTRAINT			l1tm2ttm_mplicity_NN 	CHECK ( l1tm2ttm_multiplicity IS NOT NULL),
	CONSTRAINT			l1tm2ttm_used_NN 	CHECK ( l1tm2ttm_used IS NOT NULL)
);
CREATE INDEX l1tm2ttm_trigger_menu_id_ind  ON l1_tm_to_tt_mon(l1tm2ttm_trigger_menu_id);
CREATE INDEX l1tm2ttm_trigger_thres_id_ind ON l1_tm_to_tt_mon(l1tm2ttm_trigger_threshold_id);

-- n-n relationship between the bunch group set and the bunch groups. The
-- l1_bgs_bg_internal_number is needed to label the bunch group within the 
-- bunch group set that is associated to a trigger menu. Inside the trigger
-- threshold defintion these internal numbers are referenced.
CREATE TABLE l1_bgs_to_bg (
	l1bgs2bg_id 			NUMBER(10),
	l1bgs2bg_bunch_group_set_id 	NUMBER(10),
	l1bgs2bg_bunch_group_id 	NUMBER(10),
	l1bgs2bg_internal_number	NUMBER(2),
	l1bgs2bg_username		VARCHAR2(50),
	l1bgs2bg_modified_time		TIMESTAMP,
	l1bgs2bg_used			CHAR			default 0,
	CONSTRAINT			l1bgs2bg_pk		PRIMARY KEY (l1bgs2bg_id),
	CONSTRAINT			l1bgs2bg_fk_bgs		FOREIGN KEY (l1bgs2bg_bunch_group_set_id)
								REFERENCES l1_bunch_group_set(l1bgs_id),
	CONSTRAINT			l1bgs2bg_fk_bg		FOREIGN KEY (l1bgs2bg_bunch_group_id)
								REFERENCES l1_bunch_group(l1bg_id),
	CONSTRAINT			l1bgs2bg_id_NN 		CHECK ( l1bgs2bg_id IS NOT NULL),
	CONSTRAINT			l1bgs2bg_bgrp_set_id_NN CHECK ( l1bgs2bg_bunch_group_set_id IS NOT NULL),
	CONSTRAINT			l1bgs2bg_bgrp_id_NN 	CHECK ( l1bgs2bg_bunch_group_id IS NOT NULL),
	CONSTRAINT			l1bgs2bg_int_number_NN 	CHECK ( l1bgs2bg_internal_number IS NOT NULL),
	CONSTRAINT			l1bgs2bg_used_NN 	CHECK ( l1bgs2bg_used IS NOT NULL)
);
CREATE INDEX l1bgs2bg_bgroup_set_id_ind ON l1_bgs_to_bg(l1bgs2bg_bunch_group_set_id);
CREATE INDEX l1bgs2bg_bgroup_id_ind     ON l1_bgs_to_bg(l1bgs2bg_bunch_group_id);

-- this tables associates the various bunches to the bunch groups
CREATE TABLE l1_bg_to_b (
	l1bg2b_id 			NUMBER(10), 	
	l1bg2b_bunch_group_id 		NUMBER(10), 	
	l1bg2b_bunch_number		NUMBER(10),	
	l1bg2b_username			VARCHAR2(50),
	l1bg2b_modified_time		TIMESTAMP,
	l1bg2b_used			CHAR			default 0,
	CONSTRAINT			l1bg2b_pk		PRIMARY KEY (l1bg2b_id),
	CONSTRAINT			l1bg2b_fk_bg		FOREIGN KEY (l1bg2b_bunch_group_id)
								REFERENCES l1_bunch_group(l1bg_id),
	CONSTRAINT			l1bg2b_id_NN 		CHECK ( l1bg2b_id IS NOT NULL),
	CONSTRAINT			l1bg2b_bch_group_id_NN 	CHECK ( l1bg2b_bunch_group_id IS NOT NULL),
	CONSTRAINT			l1bg2b_bch_number_NN 	CHECK ( l1bg2b_bunch_number IS NOT NULL),
	CONSTRAINT			l1bg2b_used_NN 		CHECK ( l1bg2b_used IS NOT NULL)
);
CREATE INDEX l1bg2b_bunch_group_id_ind ON l1_bg_to_b(l1bg2b_bunch_group_id);

CREATE TABLE l1_ci_to_csc (
	l1ci2csc_id                     NUMBER(10), 
        l1ci2csc_calo_info_id           NUMBER(10), 
        l1ci2csc_calo_sin_cos_id        NUMBER(10), 
        l1ci2csc_username               VARCHAR2(50),
        l1ci2csc_modified_time          TIMESTAMP,
        l1ci2csc_used                   CHAR			default 0,
        CONSTRAINT                      l1ci2csc_pk    		PRIMARY KEY (l1ci2csc_id),
        CONSTRAINT                      l1ci2csc_fk_ci  	FOREIGN KEY (l1ci2csc_calo_info_id)
                                                          	REFERENCES l1_calo_info(l1ci_id),
        CONSTRAINT                      l1ci2csc_fk_csc 	FOREIGN KEY (l1ci2csc_calo_sin_cos_id)
                                                          	REFERENCES l1_calo_sin_cos(l1csc_id),
	CONSTRAINT			l1ci2csc_id_NN 		CHECK ( l1ci2csc_id IS NOT NULL),
	CONSTRAINT			l1ci2csc_calo_info_NN 	CHECK ( l1ci2csc_calo_info_id IS NOT NULL),
	CONSTRAINT			l1ci2csc_calo_sincos_NN CHECK ( l1ci2csc_calo_sin_cos_id IS NOT NULL),
	CONSTRAINT			l1ci2csc_used_NN 	CHECK ( l1ci2csc_used IS NOT NULL)
);
CREATE INDEX l1ci2csc_calo_info_id_ind    ON l1_ci_to_csc(l1ci2csc_calo_info_id);
CREATE INDEX l1ci2csc_calo_sin_cos_id_ind ON l1_ci_to_csc(l1ci2csc_calo_sin_cos_id);

-- This table binds together all parts of the LVL1 configuration. This
-- mechanism allows to separately change the various parts separately.
-- E.g. prescale sets can be changed more often than menus.

CREATE TABLE l1_master_table (
	l1mt_id		 		NUMBER(10),
	l1mt_name			VARCHAR2(50),
	l1mt_version			NUMBER(11),
  	l1mt_comment			VARCHAR2(200),
	l1mt_trigger_menu_id		NUMBER(10),
	l1mt_dead_time_id		NUMBER(10),
	l1mt_muctpi_info_id		NUMBER(10),
	l1mt_random_id			NUMBER(10),
	l1mt_prescaled_clock_id		NUMBER(10),
	l1mt_calo_info_id		NUMBER(10),
  	l1mt_muon_threshold_set_id   	NUMBER(10),
	l1mt_username			VARCHAR2(50),
	l1mt_modified_time		TIMESTAMP,
	l1mt_status			NUMBER(2),
	l1mt_used			CHAR			default 0,
	CONSTRAINT			l1mt_pk			PRIMARY KEY (l1mt_id),
	CONSTRAINT			l1mt_fk_tm		FOREIGN KEY (l1mt_trigger_menu_id)
								REFERENCES l1_trigger_menu(l1tm_id),
	CONSTRAINT			l1mt__fk_dt		FOREIGN KEY (l1mt_dead_time_id)
								REFERENCES l1_dead_time(l1dt_id),
	CONSTRAINT			l1mt_fk_mi		FOREIGN KEY (l1mt_muctpi_info_id)
								REFERENCES l1_muctpi_info(l1mi_id),
	CONSTRAINT			l1mt_fk_r		FOREIGN KEY (l1mt_random_id)
								REFERENCES l1_random(l1r_id),
	CONSTRAINT 			l1mt_fk_psc		FOREIGN KEY (l1mt_prescaled_clock_id)
								REFERENCES l1_prescaled_clock(l1pc_id),
	CONSTRAINT			l1mt_fk_ci		FOREIGN KEY (l1mt_calo_info_id)
								REFERENCES l1_calo_info(l1ci_id),
        CONSTRAINT              	l1mt_fk_mt      	FOREIGN KEY (l1mt_muon_threshold_set_id)
                                                		REFERENCES l1_muon_threshold_set(l1mts_id),
	CONSTRAINT 			l1mt_nmver		UNIQUE (l1mt_name, l1mt_version),
	CONSTRAINT			l1mt_id_NN 		CHECK ( l1mt_id IS NOT NULL),
	CONSTRAINT			l1mt_name_NN 		CHECK ( l1mt_name IS NOT NULL),
	CONSTRAINT			l1mt_version_NN 	CHECK ( l1mt_version IS NOT NULL),
	CONSTRAINT			l1mt_trigger_menu_id_NN CHECK ( l1mt_trigger_menu_id IS NOT NULL),
	CONSTRAINT			l1mt_dead_time_id_NN 	CHECK ( l1mt_dead_time_id IS NOT NULL),
	CONSTRAINT			l1mt_muctpi_info_id_NN 	CHECK ( l1mt_muctpi_info_id IS NOT NULL),
	CONSTRAINT			l1mt_random_id_NN 	CHECK ( l1mt_random_id IS NOT NULL),
	CONSTRAINT			l1mt_pscale_clock_id_NN CHECK ( l1mt_prescaled_clock_id IS NOT NULL),
	CONSTRAINT			l1mt_calo_info_id_NN 	CHECK ( l1mt_calo_info_id IS NOT NULL),
	CONSTRAINT			l1mt_muon_thres_set_NN 	CHECK ( l1mt_muon_threshold_set_id IS NOT NULL),
	CONSTRAINT			l1mt_status_NN 		CHECK ( l1mt_status IS NOT NULL),
	CONSTRAINT			l1mt_used_NN 		CHECK ( l1mt_used IS NOT NULL)
);
CREATE INDEX l1mt_trigger_menu_id_ind       ON l1_master_table(l1mt_trigger_menu_id);
CREATE INDEX l1mt_dead_time_id_ind          ON l1_master_table(l1mt_dead_time_id);
CREATE INDEX l1mt_muctpi_info_id_ind        ON l1_master_table(l1mt_muctpi_info_id);
CREATE INDEX l1mt_random_id_ind             ON l1_master_table(l1mt_random_id);
CREATE INDEX l1mt_prescaled_clock_id_ind    ON l1_master_table(l1mt_prescaled_clock_id);
CREATE INDEX l1mt_calo_info_id_ind          ON l1_master_table(l1mt_calo_info_id);
CREATE INDEX l1mt_muon_threshold_set_id_ind ON l1_master_table(l1mt_muon_threshold_set_id);

--- HLT setup and release

-- Please emacs, make this buffer -*- sql -*-
-- Initially contributed by Johannes Haller
-- Modifications and usage Andre dos Anjos and Werner Wiedenmann
-- 18.11.05: 	Modified by Johannes Haller, to allow setup for each algorithm
--		as agreed on in meeting on 17.11.05
--
-- This schema describes the ATLAS Trigger HLT database schema. 
--
-- The schema was designed based on a separation between logical and physical
-- software infrastructure. Every Trigger release will be composed of a set of 
-- libraries with given versions that are supposed to be run by the HLT
-- processors. This set of library releases represent the "physical setup".
-- The other part of the setup is represented by the options that need to be 
-- in place for a particular logical work to happen, for instance, to run 
-- T2Calo or a combined setup. The options for running T2Calo change less 
-- frequently than the library releases and therefore it makes no sense to 
-- bind the two together.
--
-- The union of a software release (physical) and a trigger configuration 
-- setup (logical) makes up a runnable environment which is defined by 
-- a master table that correlates the two parameters. This semantic separation
-- imposes the need to build a consistency checker that assures that all
-- components in a logical setup can be run in a given (physical) Trigger 
-- software release.
--
-- Versioning:
-- Versioning information is handled by a UNIQUE constraint. A combination of
-- a particular feature on the table + a version number should be always 
-- unique to guarantee that we don't have the same versions of particular
-- parameter or setup, for instance.
-- N-to-N relationship tables hardly need versioning information.

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TABLES REPRESENTING THE LOGICAL SOFTWARE SETUP FOR A JOB
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- This table defines all parameters for all possible components I can run.
-- Different components can share the same set of paramters and every 
-- component has a set of parameters what defines a M:N relationship. This
-- unfortunately can only be addressed in SQL through a "human-unreadable" 
-- relationship table (named in this schema "comp_to_param"). To make sense
-- out of this relationship table, use the full power of SQL to make a JOIN
-- the way you prefer.
CREATE TABLE hlt_parameter (
  	hpa_id                 		NUMBER(10),
  	hpa_name          	 	VARCHAR2(50),
  	hpa_op            	 	VARCHAR2(30),
  	hpa_value         	 	VARCHAR2(4000),
  	hpa_chain_user_version 		CHAR,
  	hpa_username		 	VARCHAR2(50),
  	hpa_modified_time	 	TIMESTAMP,
  	hpa_used		 	CHAR,
  	CONSTRAINT        	 	hpa_pk        		PRIMARY KEY (hpa_id),
	CONSTRAINT			hpa_id_NN 		CHECK ( hpa_id IS NOT NULL),
	CONSTRAINT			hpa_name_NN 		CHECK ( hpa_name IS NOT NULL),
	CONSTRAINT			hpa_op_NN 		CHECK ( hpa_op IS NOT NULL),
	CONSTRAINT			hpa_value_NN 		CHECK ( hpa_value IS NOT NULL),
	CONSTRAINT			hpa_chain_user_v_NN 	CHECK ( hpa_chain_user_version IS NOT NULL),
	CONSTRAINT			hpa_used_NN 		CHECK ( hpa_used IS NOT NULL)
);

-- This table contains all components that can run for all possible
-- setups. It defines the components name, also known as 'Alias' in the
-- Gaudi world, that can be used for a given setup. The combination of
-- those is *not* free, you have to be a trigger expert to define what can run
-- in the same setup. This table is linked to a "source" table that
-- defines the originating component name and the library (DLL) it belongs to.
-- The topalg column defines if the current component should be in the top
-- algorithm list or not. The order of their execution is independent.
CREATE TABLE hlt_component (
	hcp_id       			NUMBER(10),
	hcp_name     			VARCHAR2(200),
	hcp_version  			NUMBER(11),
	hcp_alias    			VARCHAR2(200),
	hcp_type     			VARCHAR2(200),
	hcp_py_name  			VARCHAR2(200),
	hcp_py_package    		VARCHAR2(200),
	hcp_username      		VARCHAR2(50),
	hcp_modified_time		TIMESTAMP,
	hcp_used			CHAR 			default 0,
	CONSTRAINT			hcp_pk			PRIMARY KEY (hcp_id),
	CONSTRAINT			hcp_nmver 		UNIQUE (hcp_name, hcp_alias, hcp_version),
	CONSTRAINT			hcp_id_NN 		CHECK ( hcp_id IS NOT NULL),
	CONSTRAINT			hcp_name_NN 		CHECK ( hcp_name IS NOT NULL),
	CONSTRAINT			hcp_version_NN 		CHECK ( hcp_version IS NOT NULL),
	CONSTRAINT			hcp_alias_NN 		CHECK ( hcp_alias IS NOT NULL),
	CONSTRAINT			hcp_type_NN 		CHECK ( hcp_type IS NOT NULL),
	CONSTRAINT			hcp_py_name_NN 		CHECK ( hcp_py_name IS NOT NULL),
	CONSTRAINT			hcp_py_package_NN 	CHECK ( hcp_py_package IS NOT NULL),
	CONSTRAINT			hcp_used_NN 		CHECK ( hcp_used IS NOT NULL)
);

-- This table defines the relation between one component and another
-- Used to assign private tools to algorithms and more generally
-- any child component (tool) to a parent component.
-- The tools can only be reached via the cp-cp link, and the "parent" cp if an algo 
-- will be linked to a TE via the TE-CP link. 
CREATE TABLE hlt_cp_to_cp (
 	hcp2cp_id			NUMBER(10),
 	hcp2cp_parent_comp_id		NUMBER(10),
 	hcp2cp_child_comp_id		NUMBER(10),
	hcp2cp_username			VARCHAR2(50),
	hcp2cp_modified_time		TIMESTAMP,
	hcp2cp_used			CHAR			default 0,
	CONSTRAINT	  		hcp2cp_pk		PRIMARY KEY (hcp2cp_id),
 	CONSTRAINT	  		hcp2cp_fk_acp		FOREIGN KEY (hcp2cp_parent_comp_id)
   								REFERENCES hlt_component (hcp_id),
 	CONSTRAINT	  		hcp2cp_fk_tcp		FOREIGN KEY (hcp2cp_child_comp_id)
   								REFERENCES hlt_component (hcp_id),
	CONSTRAINT			hcp2cp_id_NN 		CHECK ( hcp2cp_id IS NOT NULL),
	CONSTRAINT			hcp2cp_parent_id_NN 	CHECK ( hcp2cp_parent_comp_id IS NOT NULL),
	CONSTRAINT			hcp2cp_child_id_NN 	CHECK ( hcp2cp_child_comp_id IS NOT NULL),
	CONSTRAINT			hcp2cp_used_NN 		CHECK ( hcp2cp_used IS NOT NULL)
);
CREATE INDEX hcp2cp_parent_comp_id_ind ON hlt_cp_to_cp(hcp2cp_parent_comp_id);
CREATE INDEX hcp2cp_child_comp_id_ind  ON hlt_cp_to_cp(hcp2cp_child_comp_id);

-- This table defines the relation between the component ('comp') and the
-- parameters ('param') that it has to set. It will define what you see as
-- jobOptions in the form of 'ComponentName.ProperValue = MyValue'. It is
-- a relationship table thefore it defines only foreign keys to the components
-- and parameters table
CREATE TABLE hlt_cp_to_pa (
 	hcp2pa_id			NUMBER(10),
 	hcp2pa_component_id		NUMBER(10),
 	hcp2pa_parameter_id		NUMBER(10),
	hcp2pa_username			VARCHAR2(50),
	hcp2pa_modified_time		TIMESTAMP,
	hcp2pa_used			CHAR			default 0,
	CONSTRAINT	  		hcp2pa_pk		PRIMARY KEY (hcp2pa_id),
 	CONSTRAINT	  		hcp2pa_fk_cp		FOREIGN KEY (hcp2pa_component_id)
   								REFERENCES hlt_component (hcp_id),
 	CONSTRAINT	  		hcp2pa_fk_pa		FOREIGN KEY (hcp2pa_parameter_id)
   								REFERENCES hlt_parameter (hpa_id),
	CONSTRAINT			hcp2pa_id_NN 		CHECK ( hcp2pa_id IS NOT NULL),
	CONSTRAINT			hcp2pa_component_id_NN 	CHECK ( hcp2pa_component_id IS NOT NULL),
	CONSTRAINT			hcp2pa_parameter_id_NN 	CHECK ( hcp2pa_parameter_id IS NOT NULL),
	CONSTRAINT			hcp2pa_used_NN 		CHECK ( hcp2pa_used IS NOT NULL)
);
CREATE INDEX hcp2pa_component_id_ind ON hlt_cp_to_pa(hcp2pa_component_id);
CREATE INDEX hcp2pa_parameter_id_ind ON hlt_cp_to_pa(hcp2pa_parameter_id);

-- This table defines all possible running setups one can enjoy. Since
-- a particular component can belong to a number of setups,
-- and a setup may contain many components, we need another N:N
-- relationship table. Please note that the hlt_setup table
-- is referenced by the hlt_algorithm table, ie. for each algorithm
-- in the menu we define a setup with several componennts that need to be
-- setup. Hence we can derive the components that need to run form the
-- menu. We will start with a single setup, the base setup. This means
-- the setup for all algorithms is the same. Later on , this may change
-- and we have several setups.
CREATE TABLE hlt_setup (
	hst_id				NUMBER(10),
	hst_name			VARCHAR2(50),
	hst_version			NUMBER(11),
	hst_l2_or_ef			VARCHAR(2),
	hst_username			VARCHAR2(50),
	hst_modified_time		TIMESTAMP,
	hst_used			CHAR			default 0,
	CONSTRAINT			hst_pk			PRIMARY KEY (hst_id),
	CONSTRAINT			hst_nmver 		UNIQUE (hst_name, hst_version),
	CONSTRAINT			hst_id_NN 		CHECK ( hst_id IS NOT NULL),
	CONSTRAINT			hst_name_NN 		CHECK ( hst_name IS NOT NULL),
	CONSTRAINT			hst_version_NN 		CHECK ( hst_version IS NOT NULL),
	CONSTRAINT			hst_l2_or_ef_NN 	CHECK ( hst_l2_or_ef IS NOT NULL),
	CONSTRAINT			hst_used_NN 		CHECK ( hst_used IS NOT NULL)
);

-- This table defines the N:N relations between setups and components.
CREATE TABLE hlt_st_to_cp (
	hst2cp_id			NUMBER(10),
	hst2cp_setup_id 		NUMBER(10),
	hst2cp_component_id		NUMBER(10),
	hst2cp_username			VARCHAR2(50),
	hst2cp_modified_time		TIMESTAMP,
	hst2cp_used			CHAR			default 0,
	CONSTRAINT			hst2cp_pk		PRIMARY KEY (hst2cp_id),
 	CONSTRAINT			hst2cp_fk_st		FOREIGN KEY (hst2cp_setup_id) 
								REFERENCES hlt_setup(hst_id),
	CONSTRAINT			hst2cp_fk_cp		FOREIGN KEY (hst2cp_component_id) 
								REFERENCES hlt_component(hcp_id),
	CONSTRAINT			hst2cp_id_NN 		CHECK ( hst2cp_id IS NOT NULL),
	CONSTRAINT			hst2cp_setup_id_NN 	CHECK ( hst2cp_setup_id IS NOT NULL),
	CONSTRAINT			hst2cp_component_id_NN 	CHECK ( hst2cp_component_id IS NOT NULL),
	CONSTRAINT			hst2cp_used_NN 		CHECK ( hst2cp_used IS NOT NULL)
);
CREATE INDEX hst2cp_setup_id_ind     ON hlt_st_to_cp(hst2cp_setup_id);
CREATE INDEX hst2cp_component_id_ind ON hlt_st_to_cp(hst2cp_component_id);

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TABLES REPRESENTING THE PHYSICAL SOFTWARE SETUP FOR A JOB
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- This table stores information about all available software releases.
CREATE TABLE hlt_release (
	hre_id				NUMBER(10),
	hre_name 			VARCHAR2(200),
	hre_base 			VARCHAR2(200),
	hre_patch_1 			VARCHAR2(200),
	hre_patch_2 			VARCHAR2(200),
	hre_username			VARCHAR2(50),
	hre_modified_time		TIMESTAMP,
	hre_used			CHAR			default 0,
	CONSTRAINT			hre_pk			PRIMARY KEY (hre_id),
	CONSTRAINT			hre_id_NN 		CHECK ( hre_id IS NOT NULL),
	CONSTRAINT			hre_base_NN 		CHECK ( hre_base IS NOT NULL),
	CONSTRAINT			hre_patch_1_NN 		CHECK ( hre_patch_1 IS NOT NULL),
	CONSTRAINT			hre_patch_2_NN 		CHECK ( hre_patch_2 IS NOT NULL),
	CONSTRAINT			hre_used_NN 		CHECK ( hre_used IS NOT NULL)
);

-------------------------------------------------
-- SQL script for the HLT menu part in the TriggerDB
-- date  : 24.10.05
-- author: Johannes Haller (CERN)
-------------------------------------------------

----------------------------
-- the data tables
----------------------------

-- This table describes the HLT trigger menus
-- In a given menu, the algorithms are specified that need to be configured in order to process the event
-- and to derive the trigger decision. These algorihtms need certain other algorithms or services to 
-- be running (and configured) in order to guarantee a correct event processing. For e.g. byte-stream converter
-- services. For this reason, for each menu a certain infrastructure is needed. This infrastructure is given in
-- the setup table. htm_setup_id is a foreign key to this table. When inserting a new menu it must be 
-- guaranteed that menu and setup are consistent. For the time being we will only use one setup (the 'base' setup).
-- The relationship between menu and setup could either be stored in the hlt_menu table (ergo: here) or
-- in a higher master_key table. But consistency is important. Later we could use several setups: e.g. one
-- for calorimeter algorithms, one for the muons algorihtms, a combined setup, and so on.  
CREATE TABLE hlt_trigger_menu ( 
	htm_id 				NUMBER(10),
	htm_name 			VARCHAR2(50),
	htm_version 			NUMBER(11),
	htm_phase 			VARCHAR2(50),
	htm_consistent			CHAR,
	htm_username			VARCHAR2(50),
	htm_modified_time		TIMESTAMP,
	htm_used			CHAR			default 0,
	CONSTRAINT 			htm_pk			PRIMARY KEY (htm_id),
	CONSTRAINT 			htm_nmver		UNIQUE (htm_name, htm_version),
	CONSTRAINT			htm_id_NN 		CHECK ( htm_id IS NOT NULL),
	CONSTRAINT			htm_name_NN 		CHECK ( htm_name IS NOT NULL),
	CONSTRAINT			htm_version_NN 		CHECK ( htm_version IS NOT NULL),
	CONSTRAINT			htm_phase_NN 		CHECK ( htm_phase IS NOT NULL),
	CONSTRAINT			htm_consistent_NN 	CHECK ( htm_consistent IS NOT NULL),
	CONSTRAINT			htm_used_NN 		CHECK ( htm_used IS NOT NULL)
);


-- This table describes hlt_chains which are 'a' trigger in L2 or EF, i.e. a chain of 
-- signatures. For each processing step, there is one signature.
-- The attirbute htcc_lower_chain_name gives the name of the signatures this chain is based on.
-- In case of a L2 chain, this column gives the LVL1 trigger item. For EF chains
-- this string is the name of a L2 chain. When combining the LVL1 menu and the HLT part,
-- it must be made sure that the lower signatures that are expected by L2 are also configured
-- in the LVL1 part. The same for EF and L2. We don't put foreign keys here to the actual signature
-- but rahter strings of the name. This allows to change the LVL1 (LVL2) trigger menu items without
-- necessarily changing the LVL2 (EF) trigger menu.
-- The attribute htc_l2_or_ef is a flag that indicates if a certain chain runs on L2 or the EF. Since the 
-- configuration of L2 and EF are basically identical, this flag allows us to use all tables
-- for both L2 and EF.
CREATE TABLE hlt_trigger_chain (
  	htc_id                 		NUMBER(10),
 	htc_name               		VARCHAR2(50),
 	htc_version            		NUMBER(11),
  	htc_user_version       		NUMBER(11),
  	htc_comment		 	VARCHAR2(50),
  	htc_chain_counter      		NUMBER(10),
  	htc_lower_chain_name  		VARCHAR2(50),
  	htc_l2_or_ef           		VARCHAR2(2),
  	htc_rerun_prescale     		VARCHAR2(50),
  	htc_username           		VARCHAR2(50),
  	htc_modified_time      		TIMESTAMP,
  	htc_used               		CHAR          		default 0,
  	CONSTRAINT 			htc_pk      		PRIMARY KEY (htc_id),
  	CONSTRAINT 			htc_nmver   		UNIQUE (htc_name, htc_version),
	CONSTRAINT			htc_id_NN 		CHECK ( htc_id IS NOT NULL),
	CONSTRAINT			htc_name_NN 		CHECK ( htc_name IS NOT NULL),
	CONSTRAINT			htc_version_NN 		CHECK ( htc_version IS NOT NULL),
	CONSTRAINT			htc_user_version_NN 	CHECK ( htc_user_version IS NOT NULL),
	CONSTRAINT			htc_chain_counter_NN 	CHECK ( htc_chain_counter IS NOT NULL),
	CONSTRAINT			htc_lower_chain_name_NN CHECK ( htc_lower_chain_name IS NOT NULL),
	CONSTRAINT			htc_l2_or_ef_NN 	CHECK ( htc_l2_or_ef IS NOT NULL),
	CONSTRAINT			htc_rereun_prescale_NN 	CHECK ( htc_rerun_prescale IS NOT NULL),
	CONSTRAINT			htc_used_NN 		CHECK ( htc_used IS NOT NULL)
);

-- this table describes the signatures at each step of a chain.
-- The attribute hs_logic identifies the logic expression with which trigger_elements are combined
-- in this step. At the moment we use an integer to encode this logic. e.g. hs_logic=1 means
-- that all trigger_element are used in an AND expression. We expect that the number
-- of different logical experssions will be rather small. Then this encoded logic makes sense.
-- LAter one could change it to a string and parser code to encode the logic. The implementation of a
-- proper logical tree with AND and OR nodes seems to be an over-kill.
CREATE TABLE hlt_trigger_signature ( 
	hts_id 				NUMBER(10),
	hts_logic			NUMBER(2),
	hts_username 			VARCHAR2(50),
	hts_modified_time		TIMESTAMP,
	hts_used			CHAR			default 0,
	CONSTRAINT 			hts_pk			PRIMARY KEY (hts_id),
	CONSTRAINT			hts_id_NN 		CHECK ( hts_id IS NOT NULL),
	CONSTRAINT			hts_logic_NN 		CHECK ( hts_logic IS NOT NULL),
	CONSTRAINT			hts_used_NN 		CHECK ( hts_used IS NOT NULL)
);

-- Steps are logical combination of trigger_elements. These trigger_elements are defined in 
-- this table. 
CREATE TABLE hlt_trigger_element ( 
	hte_id            		NUMBER(10),
	hte_name          		VARCHAR2(100),
	hte_version       		NUMBER(11),
	hte_username      		VARCHAR2(50),
	hte_modified_time 		TIMESTAMP,
	hte_used          		CHAR         		default 0,
	CONSTRAINT 			hte_pk			PRIMARY KEY (hte_id),
	CONSTRAINT			hte_id_NN 		CHECK ( hte_id IS NOT NULL),
	CONSTRAINT			hte_name_NN 		CHECK ( hte_name IS NOT NULL),
	CONSTRAINT			hte_version_NN 		CHECK ( hte_version IS NOT NULL),
	CONSTRAINT			hte_used_NN 		CHECK ( hte_used IS NOT NULL)
 );

-- Prescale sets are supposed to be changed more often than the menu logic. 
-- Therefore this separate table is introduced. It binds all 
-- prescale values. There will be several Prescale Sets for a certain menu. 
CREATE TABLE hlt_prescale_set ( 
	hps_id                    	NUMBER(10),
  	hps_name                  	VARCHAR2(65),
  	hps_version               	NUMBER(11),
 	hps_comment	            	VARCHAR2(200),
  	hps_username              	VARCHAR2(50),
 	hps_modified_time         	TIMESTAMP,
  	hps_used                  	CHAR         		default 0,
  	CONSTRAINT  			hps_pk        		PRIMARY KEY (hps_id),
  	CONSTRAINT  			hps_nmver     		UNIQUE (hps_name, hps_version),
	CONSTRAINT			hps_id_NN 		CHECK ( hps_id IS NOT NULL),
	CONSTRAINT			hps_name_NN 		CHECK ( hps_name IS NOT NULL),
	CONSTRAINT			hps_version_NN 		CHECK ( hps_version IS NOT NULL),
	CONSTRAINT			hps_used_NN 		CHECK ( hps_used IS NOT NULL)
);

-- Here the various prescale factors are listed for a certain set.
CREATE TABLE hlt_prescale (
  	hpr_id              		NUMBER(10),
  	hpr_prescale_set_id  		NUMBER(10),
  	hpr_chain_counter    		NUMBER(10),
  	hpr_l2_or_ef        		VARCHAR2(2),
  	hpr_prescale        		VARCHAR2(50),
  	hpr_pass_through_rate 		VARCHAR2(50),
  	hpr_username        		VARCHAR2(50),
  	hpr_modified_time   		TIMESTAMP,
  	hpr_used            		CHAR        		default 0,
  	CONSTRAINT     			hpr_pk    		PRIMARY KEY (hpr_id),
  	CONSTRAINT    			hpr_fk_ps  		FOREIGN KEY (hpr_prescale_set_id) 
           							REFERENCES hlt_prescale_set(hps_id),
	CONSTRAINT			hpr_id_NN 		CHECK ( hpr_id IS NOT NULL),
	CONSTRAINT			hpr_prescale_set_id_NN 	CHECK ( hpr_prescale_set_id IS NOT NULL),
	CONSTRAINT			hpr_chain_counter_NN 	CHECK ( hpr_chain_counter IS NOT NULL),
	CONSTRAINT			hpr_l2_or_ef_NN 	CHECK ( hpr_l2_or_ef IS NOT NULL),
	CONSTRAINT			hpr_prescale_NN 	CHECK ( hpr_prescale IS NOT NULL),
	CONSTRAINT			hpr_pass_thru_rate_NN 	CHECK ( hpr_pass_through_rate IS NOT NULL),
	CONSTRAINT			hpr_used_NN 		CHECK ( hpr_used IS NOT NULL)
);
CREATE INDEX hpr_prescale_set_id_ind ON hlt_prescale(hpr_prescale_set_id);

----------------------
-- N-N relations
----------------------

-- Relates the HLT prescale sets to the HLT menu. Hence if the menu changes
-- the same set may still be applied
CREATE TABLE hlt_tm_to_ps ( 
	htm2ps_id 			NUMBER(10),
	htm2ps_trigger_menu_id 		NUMBER(10),
	htm2ps_prescale_set_id  	NUMBER(10),
	htm2ps_username 		VARCHAR2(50),
	htm2ps_modified_time		TIMESTAMP,
	htm2ps_used			CHAR			default 0,
	CONSTRAINT			htm2ps_pk		PRIMARY KEY (htm2ps_id),
	CONSTRAINT			htm2ps_fk_tm		FOREIGN KEY (htm2ps_trigger_menu_id) 
								REFERENCES hlt_trigger_menu(htm_id),
	CONSTRAINT			htm2ps_fk_ps		FOREIGN KEY (htm2ps_prescale_set_id)
								REFERENCES hlt_prescale_set(hps_id),
	CONSTRAINT			htm2ps_id_NN 		CHECK ( htm2ps_id IS NOT NULL),
	CONSTRAINT			htm2ps_menu_id_NN 	CHECK ( htm2ps_trigger_menu_id IS NOT NULL),
	CONSTRAINT			htm2ps_set_id_NN 	CHECK ( htm2ps_prescale_set_id IS NOT NULL),
	CONSTRAINT			htm2ps_used_NN 		CHECK ( htm2ps_used IS NOT NULL)
);
CREATE INDEX htm2ps_trigger_menu_id_ind ON hlt_tm_to_ps(htm2ps_trigger_menu_id);
CREATE INDEX htm2ps_prescale_set_id_ind ON hlt_tm_to_ps(htm2ps_prescale_set_id);

-- In this table it is specified which chains are included in a certain menu.
-- For each menu the chains are counted and they are attributed a certain counter value in this menu.
-- This id can then be used e.g. for trigger_bits in a trigger_bit_pattern and also for
-- the prescale_set table in which the prescale for the various chains are stored. Please note
-- that these prescales are supposed to be changed more frequently than full menus. That's why a 
-- separate table is introduced.
CREATE TABLE hlt_tm_to_tc ( 
	htm2tc_id 			NUMBER(10),
	htm2tc_trigger_menu_id 		NUMBER(10),
	htm2tc_trigger_chain_id 	NUMBER(10),
	htm2tc_username 		VARCHAR2(50),
	htm2tc_modified_time		TIMESTAMP,
	htm2tc_used			CHAR			default 0,
	CONSTRAINT			htm2tc_pk		PRIMARY KEY (htm2tc_id),
	CONSTRAINT			htm2tc_fk_tm		FOREIGN KEY (htm2tc_trigger_menu_id) 
								REFERENCES hlt_trigger_menu(htm_id),
	CONSTRAINT			htm2tc_fk_tc		FOREIGN KEY (htm2tc_trigger_chain_id)
								REFERENCES hlt_trigger_chain(htc_id),
	CONSTRAINT			htm2tc_id_NN 		CHECK ( htm2tc_id IS NOT NULL),
	CONSTRAINT			htm2tc_trig_menu_id_NN 	CHECK ( htm2tc_trigger_menu_id IS NOT NULL),
	CONSTRAINT			htm2tc_trig_chain_id_NN CHECK ( htm2tc_trigger_chain_id IS NOT NULL),
	CONSTRAINT			htm2tc_used_NN 		CHECK ( htm2tc_used IS NOT NULL)
);
CREATE INDEX htm2tc_trigger_menu_id_ind  ON hlt_tm_to_tc(htm2tc_trigger_menu_id);
CREATE INDEX htm2tc_trigger_chain_id_ind ON hlt_tm_to_tc(htm2tc_trigger_chain_id);

-- one chain is composed of several steps/signatures.
-- one step/signature can appear in several trigger chains.
-- The attribute htc2ts_step_counter indicates the order of steps in a chain. For a chain with 4 steps
-- there should be 4 steps with counter= 1,2,3,4
CREATE TABLE hlt_tc_to_ts ( 
	htc2ts_id 			NUMBER(10),
	htc2ts_trigger_chain_id 	NUMBER(10),
	htc2ts_trigger_signature_id 	NUMBER(10),
	htc2ts_signature_counter 	NUMBER(10),
	htc2ts_username 		VARCHAR2(50),
	htc2ts_modified_time		TIMESTAMP,
	htc2ts_used			CHAR			default 0,
	CONSTRAINT			htc2ts_pk		PRIMARY KEY (htc2ts_id),
	CONSTRAINT			htc2ts_fk_tc		FOREIGN KEY (htc2ts_trigger_chain_id) 
						 		REFERENCES hlt_trigger_chain(htc_id),
	CONSTRAINT			htc2ts_fk_ts		FOREIGN KEY (htc2ts_trigger_signature_id)
								REFERENCES hlt_trigger_signature(hts_id),
	CONSTRAINT			htc2ts_id_NN 		CHECK ( htc2ts_id IS NOT NULL),
	CONSTRAINT			htc2ts_trig_chain_id_NN CHECK ( htc2ts_trigger_chain_id IS NOT NULL),
	CONSTRAINT			htc2ts_trig_sig_id_NN 	CHECK ( htc2ts_trigger_signature_id IS NOT NULL),
	CONSTRAINT			htc2ts_sig_counter_NN 	CHECK ( htc2ts_signature_counter IS NOT NULL),
	CONSTRAINT			htc2ts_used_NN 		CHECK ( htc2ts_used IS NOT NULL)
);
CREATE INDEX htc2ts_trigr_chain_id_ind ON hlt_tc_to_ts(htc2ts_trigger_chain_id);
CREATE INDEX htc2ts_trigr_sig_id_ind   ON hlt_tc_to_ts(htc2ts_trigger_signature_id);

-- this table constains the group info
--   for monitoring purposes trigger chains 
--   can be grouped together, one can think
--   of electron, muon, tau groups, etc.
CREATE TABLE hlt_trigger_group (
  	htg_id                 		NUMBER(10),
  	htg_trigger_chain_id   		NUMBER(10),
  	htg_name               		VARCHAR2(50),
  	htg_username           		VARCHAR2(50),
  	htg_modified_time      		TIMESTAMP,
  	htg_used               		CHAR         		default 0,
  	CONSTRAINT 			htg_pk      		PRIMARY KEY (htg_id),
  	CONSTRAINT 			htg_fk_tc   		FOREIGN KEY (htg_trigger_chain_id)  
								REFERENCES hlt_trigger_chain(htc_id),
	CONSTRAINT			htg_id_NN 		CHECK ( htg_id IS NOT NULL),
	CONSTRAINT			htg_trigger_chain_id_NN CHECK ( htg_trigger_chain_id IS NOT NULL),
	CONSTRAINT			htg_name_NN 		CHECK ( htg_name IS NOT NULL),
	CONSTRAINT			htg_used_NN 		CHECK ( htg_used IS NOT NULL)
);
CREATE INDEX htg_trigger_chain_id_ind ON hlt_trigger_group(htg_trigger_chain_id);

-- this table constains the trigger type info
CREATE TABLE hlt_trigger_type (
  	htt_id                 		NUMBER(10),
  	htt_trigger_chain_id   		NUMBER(10),
  	htt_typebit            		NUMBER(10),
  	htt_username           		VARCHAR2(50),
  	htt_modified_time      		TIMESTAMP,
  	htt_used               		CHAR       		default 0,	
  	CONSTRAINT 			htt_pk      		PRIMARY KEY (htt_id),
  	CONSTRAINT 			htt_fk_tc   		FOREIGN KEY (htt_trigger_chain_id)  	
								REFERENCES hlt_trigger_chain(htc_id),
	CONSTRAINT			htt_id_NN 		CHECK ( htt_id IS NOT NULL),
	CONSTRAINT			htt_trigger_chain_id_NN CHECK ( htt_trigger_chain_id IS NOT NULL),
	CONSTRAINT			htt_used_NN 		CHECK ( htt_used IS NOT NULL)
);


-- this table constains the stream info
CREATE TABLE hlt_trigger_stream (
  	htr_id                 		NUMBER(10),
  	htr_name               		VARCHAR2(50),
 	htr_description        		VARCHAR2(200),
  	htr_type               		VARCHAR2(50),
  	htr_obeyLB             		NUMBER(1),
  	htr_username           		VARCHAR2(50),
  	htr_modified_time      		TIMESTAMP,
  	htr_used               		CHAR         		default 0,
  	CONSTRAINT 			htr_pk      		PRIMARY KEY (htr_id),
	CONSTRAINT			htr_id_NN 		CHECK ( htr_id IS NOT NULL),
	CONSTRAINT			htr_name_NN 		CHECK ( htr_name IS NOT NULL),
	CONSTRAINT			htr_description_NN 	CHECK ( htr_description IS NOT NULL),
	CONSTRAINT			htr_type_NN 		CHECK ( htr_type IS NOT NULL),
	CONSTRAINT			htr_obeyLB_NN 		CHECK ( htr_obeyLB IS NOT NULL),
	CONSTRAINT			htr_used_NN 		CHECK ( htr_used IS NOT NULL)
);


-- this table connects the trigger chains with the
-- data stream definitions
-- an M:N connection is needed, since a chain can
-- feet multiple data streams, while a data stream
-- can be fed by multiple chains

CREATE TABLE hlt_tc_to_tr (
 	htc2tr_id                      	NUMBER(10),
  	htc2tr_trigger_chain_id        	NUMBER(10),
  	htc2tr_trigger_stream_id       	NUMBER(10),
  	htc2tr_trigger_stream_prescale 	VARCHAR2(50),
  	htc2tr_username                	VARCHAR2(50),
  	htc2tr_modified_time           	TIMESTAMP,
  	htc2tr_used                    	CHAR         		default 0,
  	CONSTRAINT			htc2tr_pk           	PRIMARY KEY (htc2tr_id),
  	CONSTRAINT 			htc2tr_fk_tc        	FOREIGN KEY (htc2tr_trigger_chain_id)  
								REFERENCES hlt_trigger_chain(htc_id),
  	CONSTRAINT 			htc2tr_fk_tm        	FOREIGN KEY (htc2tr_trigger_stream_id) 
								REFERENCES hlt_trigger_stream(htr_id),
	CONSTRAINT			htc2tr_id_NN 		CHECK ( htc2tr_id IS NOT NULL),
	CONSTRAINT			htc2tr_trig_chain_NN 	CHECK ( htc2tr_trigger_chain_id IS NOT NULL),
	CONSTRAINT			htc2tr_trig_str_NN 	CHECK ( htc2tr_trigger_stream_id IS NOT NULL),
	CONSTRAINT			htc2tr_trig_str_ps_NN 	CHECK ( htc2tr_trigger_stream_prescale IS NOT NULL),
	CONSTRAINT			htc2tr_used_id_NN 	CHECK ( htc2tr_used IS NOT NULL)
);
CREATE INDEX htc2tr_trigger_chain_id_ind  ON hlt_tc_to_tr(htc2tr_trigger_chain_id);
CREATE INDEX htc2tr_trigger_stream_id_ind ON hlt_tc_to_tr(htc2tr_trigger_stream_id);

-- one signature has several trigger_elements.
CREATE TABLE hlt_ts_to_te ( 
  	hts2te_id                     	NUMBER(10),
  	hts2te_trigger_signature_id   	NUMBER(10),
  	hts2te_trigger_element_id     	NUMBER(10),
  	hts2te_element_counter        	NUMBER(10),
  	hts2te_username               	VARCHAR2(50),
  	hts2te_modified_time          	TIMESTAMP,
  	hts2te_used                   	CHAR         		default 0,
  	CONSTRAINT      		hts2te_pk     		PRIMARY KEY (hts2te_id),
  	CONSTRAINT      		hts2te_fk_ts  		FOREIGN KEY (hts2te_trigger_signature_id) 
                                  				REFERENCES hlt_trigger_signature(hts_id),
  	CONSTRAINT      		hts2te_fk_te 		FOREIGN KEY (hts2te_trigger_element_id)
                                  				REFERENCES hlt_trigger_element(hte_id),
	CONSTRAINT			hts2te_id_NN 		CHECK ( hts2te_id IS NOT NULL),
	CONSTRAINT			hts2te_trig_sig_id_NN 	CHECK ( hts2te_trigger_signature_id IS NOT NULL),
	CONSTRAINT			hts2te_trig_ele_id_NN 	CHECK ( hts2te_trigger_element_id IS NOT NULL),
	CONSTRAINT			hts2te_ele_counter_NN 	CHECK ( hts2te_element_counter IS NOT NULL),
	CONSTRAINT			hts2te_used_id_NN 	CHECK ( hts2te_used IS NOT NULL)
);
CREATE INDEX hts2te_trigr_sig__id_ind ON hlt_ts_to_te(hts2te_trigger_signature_id);
CREATE INDEX hts2te_trigr_ele_id_ind  ON hlt_ts_to_te(hts2te_trigger_element_id);

-- This table describes the N-N relation between trigger_elements and algorithm component.
CREATE TABLE hlt_te_to_cp (
  	hte2cp_id                 	NUMBER(10),
  	hte2cp_trigger_element_id	NUMBER(10),
  	hte2cp_component_id       	NUMBER(10),
  	hte2cp_algorithm_counter  	NUMBER(10),
  	hte2cp_username           	VARCHAR2(30),
  	hte2cp_modified_time      	TIMESTAMP,
  	hte2cp_used               	CHAR        		default 0,
  	CONSTRAINT  			hte2cp_pk     		PRIMARY KEY (hte2cp_id),
  	CONSTRAINT  			hte2cp_fk_te  		FOREIGN KEY (hte2cp_trigger_element_id) 
                            					REFERENCES hlt_trigger_element(hte_id),
  	CONSTRAINT  			hte2cp_fk_cp  		FOREIGN KEY (hte2cp_component_id)
                            					REFERENCES hlt_component(hcp_id),
	CONSTRAINT			hte2cp_id_NN 		CHECK ( hte2cp_id IS NOT NULL),
	CONSTRAINT			hte2cp_trig_ele_id_NN 	CHECK ( hte2cp_trigger_element_id IS NOT NULL),
	CONSTRAINT			hte2cp_comp_id_NN 	CHECK ( hte2cp_component_id IS NOT NULL),
	CONSTRAINT			hte2cp_algo_counter_NN 	CHECK ( hte2cp_algorithm_counter IS NOT NULL),
	CONSTRAINT			hte2cp_used_NN 		CHECK ( hte2cp_used IS NOT NULL)
);
CREATE INDEX hte2cp_trigger_element_id_ind ON hlt_te_to_cp(hte2cp_trigger_element_id);
CREATE INDEX hte2cp_component_id_ind       ON hlt_te_to_cp(hte2cp_component_id);

-- This table allows to specify several input trigger elements for an output trigger
-- element produced by a certain algorithm. hte2te_trigger_element_id gives the
-- trigger_element to be produced and hte2te_trigger_element_inp_id gives the input
-- trigger elements. The property of an algorithm to produce multiple trigger_elements
-- can be indicated in the DB by multiple links from one hlt_trigger_signature to the 
-- hlt_trigger_element table. In order to distinguish multiple separate trigger_elements
-- produced in multiple runnings of a algorithm from multiple trigger elements produced
-- by an algorithm in just one running, the hcp_flag attribute in the hlt_component table 
-- must be used (This is a property of the algorithm!).

CREATE TABLE hlt_te_to_te (
  	hte2te_id                  	NUMBER(10),
  	hte2te_te_id               	NUMBER(10),
  	hte2te_te_inp_id           	VARCHAR2(100),
  	hte2te_te_inp_type         	VARCHAR2(10),
  	hte2te_te_counter          	NUMBER(3),
  	hte2te_username            	VARCHAR2(50),
  	hte2te_modified_time       	TIMESTAMP,
  	hte2te_used                	CHAR        		default 0,
	CONSTRAINT 			hte2te_pk       	PRIMARY KEY (hte2te_id),
  	CONSTRAINT 			hte2cte_fk_te   	FOREIGN KEY (hte2te_te_id) 
                               					REFERENCES hlt_trigger_element(hte_id),
	CONSTRAINT			hte2te_id_NN 		CHECK ( hte2te_id IS NOT NULL),
	CONSTRAINT			hte2te_te_id_NN 	CHECK ( hte2te_te_id IS NOT NULL),
	CONSTRAINT			hte2te_te_inp_id_NN 	CHECK ( hte2te_te_inp_id IS NOT NULL),
	CONSTRAINT			hte2te_te_inp_type_NN 	CHECK ( hte2te_te_inp_type IS NOT NULL),
	CONSTRAINT			hte2te_te_counter_NN 	CHECK ( hte2te_te_counter IS NOT NULL),
	CONSTRAINT			hte2te_used_NN 		CHECK ( hte2te_used IS NOT NULL)
 );
CREATE INDEX hte2te_te_id_ind ON hlt_te_to_te(hte2te_te_id);

-- Tables presenting the rules to convert the online setup into an offline
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- HLT RULES
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- this table contains the rule set info
CREATE TABLE HLT_RULE_SET (
  	hrs_id                 		NUMBER(10),
  	hrs_name               		VARCHAR2(50),
  	hrs_version            		NUMBER(11),
 	hrs_username           		VARCHAR2(50),
  	hrs_modified_time      		TIMESTAMP,
  	hrs_used               		CHAR          		default 0,
  	CONSTRAINT 			hrs_pk      		PRIMARY KEY (hrs_id),
  	CONSTRAINT 			hrs_nmver   		UNIQUE (hrs_name, hrs_version),
	CONSTRAINT			hrs_id_NN 		CHECK ( hrs_id IS NOT NULL),
	CONSTRAINT			hrs_name_NN 		CHECK ( hrs_name IS NOT NULL),
	CONSTRAINT			hrs_version_NN 		CHECK ( hrs_version IS NOT NULL),
	CONSTRAINT			hrs_used_NN 		CHECK ( hrs_used IS NOT NULL)
);


-- This table contains the rule info
-- hru_type:
--     1 - Replace
--     2 - Rename
--     3 - Modify
--     4 - Merge
--     5 - Sort
--     6 - Copy

CREATE TABLE HLT_RULE (
  	hru_id                 		NUMBER(10),
  	hru_name               		VARCHAR2(50),
  	hru_version            		NUMBER(11),
  	hru_type               		NUMBER(1),
  	hru_username           		VARCHAR2(50),
  	hru_modified_time      		TIMESTAMP,
  	hru_used               		CHAR          		default 0,
  	CONSTRAINT			hru_pk      		PRIMARY KEY (hru_id),
  	CONSTRAINT 			hru_nmvertp 		UNIQUE (hru_name, hru_version, hru_type),
	CONSTRAINT			hru_id_NN 		CHECK ( hru_id IS NOT NULL),
	CONSTRAINT			hru_name_NN 		CHECK ( hru_name IS NOT NULL),
	CONSTRAINT			hru_version_NN 		CHECK ( hru_version IS NOT NULL),
	CONSTRAINT			hru_type_NN 		CHECK ( hru_type IS NOT NULL),
	CONSTRAINT			hru_used_NN 		CHECK ( hru_used IS NOT NULL)
);

-- this table contains the rule component
-- the structure of the table is identical to the hlt_component
CREATE TABLE HLT_RULE_COMPONENT (
  	hrc_id                		NUMBER(10),
  	hrc_name              		VARCHAR2(200),
  	hrc_version           		NUMBER(11),
  	hrc_alias             		VARCHAR2(200),
  	hrc_type              		VARCHAR2(50),
  	hrc_py_name           		VARCHAR2(200),
  	hrc_py_package        		VARCHAR2(200),
  	hrc_username          		VARCHAR2(50),
  	hrc_modified_time     		TIMESTAMP,
  	hrc_used              		CHAR 			default 0,
  	CONSTRAINT    			hrc_pk      		PRIMARY KEY (hrc_id),
  	CONSTRAINT    			hrc_nmver   		UNIQUE (hrc_name, hrc_alias, hrc_version),
	CONSTRAINT			hrc_id_NN 		CHECK ( hrc_id IS NOT NULL),
	CONSTRAINT			hrc_name_NN 		CHECK ( hrc_name IS NOT NULL),
	CONSTRAINT			hrc_version_NN 		CHECK ( hrc_version IS NOT NULL),
	CONSTRAINT			hrc_alias_NN 		CHECK ( hrc_alias IS NOT NULL),
	CONSTRAINT			hrc_type_NN 		CHECK ( hrc_type IS NOT NULL),
	CONSTRAINT			hrc_py_name_NN 		CHECK ( hrc_py_name IS NOT NULL),
	CONSTRAINT			hrc_py_package_NN 	CHECK ( hrc_py_package IS NOT NULL),
	CONSTRAINT			hrc_used_NN 		CHECK ( hrc_used IS NOT NULL)
);

-- This table defines rule parameters
-- its structure is identical to the hlt_parameter
CREATE TABLE HLT_RULE_PARAMETER (
 	hrp_id              		NUMBER(10),
  	hrp_name            		VARCHAR2(50),
  	hrp_op              		VARCHAR2(30),
  	hrp_value           		VARCHAR2(4000),
  	hrp_username        		VARCHAR2(50),
  	hrp_modified_time   		TIMESTAMP,
 	hrp_used            		CHAR      		default 0,
  	CONSTRAINT          		hrp_pk          	PRIMARY KEY (hrp_id),
	CONSTRAINT			hrp_id_NN 		CHECK ( hrp_id IS NOT NULL),
	CONSTRAINT			hrp_name_NN 		CHECK ( hrp_name IS NOT NULL),
	CONSTRAINT			hrp_op_NN 		CHECK ( hrp_op IS NOT NULL),
	CONSTRAINT			hrp_value_NN 		CHECK ( hrp_value IS NOT NULL),
	CONSTRAINT			hrp_used_NN 		CHECK ( hrp_used IS NOT NULL)
);

-- ________________________________________________________________________
-- HLT RULES - N:M tables
-- ________________________________________________________________________

-- This table describes N:M relation between HLT_RELEASE and HLT_RULE_SET
CREATE TABLE HLT_HRE_TO_HRS (
  	hre2rs_id                      	NUMBER(10),
  	hre2rs_release_id              	NUMBER(10),
  	hre2rs_rule_set_id             	NUMBER(10),
  	hre2rs_username                	VARCHAR2(50),
  	hre2rs_modified_time           	TIMESTAMP,
  	hre2rs_used                    	CHAR         		default 0,
  	CONSTRAINT 			hre2rs_pk           	PRIMARY KEY (hre2rs_id),
  	CONSTRAINT 			hre2rs_fk_ru        	FOREIGN KEY (hre2rs_release_id)   
								REFERENCES HLT_RELEASE(hre_id),
  	CONSTRAINT 			hre2rs_fk_rs        	FOREIGN KEY (hre2rs_rule_set_id)  
								REFERENCES HLT_RULE_SET(hrs_id),
	CONSTRAINT			hre2rs_id_NN 		CHECK ( hre2rs_id IS NOT NULL),
	CONSTRAINT			hre2rs_used_NN 		CHECK ( hre2rs_used IS NOT NULL)
);
CREATE INDEX hre2rs_release_id_ind  ON HLT_HRE_TO_HRS(hre2rs_release_id);
CREATE INDEX hre2rs_rule_set_id_ind ON HLT_HRE_TO_HRS(hre2rs_rule_set_id);


-- This table describes N:M relation between HLT_RULE_SET and HLT_RULE
-- The Rule order matters - hrs2ru_rule_counter states the position of the rule in the XML file
CREATE TABLE HLT_HRS_TO_HRU (
  	hrs2ru_id                      	NUMBER(10),
  	hrs2ru_rule_set_id             	NUMBER(10),
  	hrs2ru_rule_id                 	NUMBER(10),
  	hrs2ru_rule_counter            	NUMBER(10),
  	hrs2ru_username                	VARCHAR2(50),
  	hrs2ru_modified_time           	TIMESTAMP,
  	hrs2ru_used                    	CHAR         		default 0,
  	CONSTRAINT			hrs2ru_pk           	PRIMARY KEY (hrs2ru_id),
  	CONSTRAINT 			hrs2ru_fk_rs        	FOREIGN KEY (hrs2ru_rule_set_id)  
								REFERENCES HLT_RULE_SET(hrs_id),
  	CONSTRAINT 			hrs2ru_fk_ru        	FOREIGN KEY (hrs2ru_rule_id) 
								REFERENCES HLT_RULE(hru_id),
	CONSTRAINT			hrs2ru_id_NN 		CHECK ( hrs2ru_id IS NOT NULL),
	CONSTRAINT			hrs2ru_rule_counter_NN 	CHECK ( hrs2ru_rule_counter IS NOT NULL),
	CONSTRAINT			hrs2ru_used_NN 		CHECK ( hrs2ru_used IS NOT NULL)
);
CREATE INDEX hrs2ru_rule_id_ind     ON HLT_HRS_TO_HRU(hrs2ru_rule_id);
CREATE INDEX hrs2ru_rule_set_id_ind ON HLT_HRS_TO_HRU(hrs2ru_rule_set_id);


-- This table describes N:M relation between HLT_RULE and HLT_RULE_COMPONENT
-- hrs2rc_component_type: 0 - unasigned (used for Merge and Sort rules), 1 - online component, 2 - offline component
CREATE TABLE HLT_HRU_TO_HRC (
  	hru2rc_id                      	NUMBER(10),   
  	hru2rc_rule_id                 	NUMBER(10),
  	hru2rc_component_id            	NUMBER(10),
  	hru2rc_component_type          	NUMBER(1),
  	hru2rc_username                	VARCHAR2(50),
  	hru2rc_modified_time           	TIMESTAMP,
  	hru2rc_used                    	CHAR         		default 0,
  	CONSTRAINT 			hru2rc_pk           	PRIMARY KEY (hru2rc_id),
  	CONSTRAINT 			hru2rc_fk_ru        	FOREIGN KEY (hru2rc_rule_id)
								REFERENCES HLT_RULE(hru_id),
  	CONSTRAINT 			hru2rc_fk_rc        	FOREIGN KEY (hru2rc_component_id) 
								REFERENCES HLT_RULE_COMPONENT(hrc_id),
  	CONSTRAINT 			hru2rc_rurcct       	UNIQUE (hru2rc_rule_id, hru2rc_component_id, hru2rc_component_type),
	CONSTRAINT			hru2rc_id_NN 		CHECK ( hru2rc_id IS NOT NULL),
	CONSTRAINT			hru2rc_used_NN 		CHECK ( hru2rc_used IS NOT NULL)
);
CREATE INDEX hru2rc_rule_id_ind ON HLT_HRU_TO_HRC(hru2rc_rule_id);
CREATE INDEX hru2rc_component_id_ind ON HLT_HRU_TO_HRC(hru2rc_component_id);


-- This table describes N:M relation between HLT_RULE_COMPONENT and HLT_RULE_PARAMETER
-- identical structure to HLT_CP_TO_PA
CREATE TABLE HLT_HRC_TO_HRP (
  	hrc2rp_id                      	NUMBER(10),
  	hrc2rp_component_id            	NUMBER(10),
  	hrc2rp_parameter_id            	NUMBER(10),
  	hrc2rp_username                	VARCHAR2(50),
  	hrc2rp_modified_time           	TIMESTAMP,
  	hrc2rp_used                    	CHAR         		default 0,
  	CONSTRAINT 			hrc2rp_pk           	PRIMARY KEY (hrc2rp_id),
  	CONSTRAINT 			hrc2rp_fk_rc        	FOREIGN KEY (hrc2rp_component_id) 
								REFERENCES HLT_RULE_COMPONENT(hrc_id),
  	CONSTRAINT 			hrc2rp_fk_rp        	FOREIGN KEY (hrc2rp_parameter_id) 
								REFERENCES HLT_RULE_PARAMETER(hrp_id),
	CONSTRAINT			hrc2rp_id_NN 		CHECK ( hrc2rp_id IS NOT NULL),
	CONSTRAINT			hrc2rp_used_NN 		CHECK ( hrc2rp_used IS NOT NULL)
);
CREATE INDEX hrc2rp_component_id_ind ON HLT_HRC_TO_HRP(hrc2rp_component_id);
CREATE INDEX hrc2rp_parameter_id_ind ON HLT_HRC_TO_HRP(hrc2rp_parameter_id);

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- MASTER TABLE
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-- This table is the HLT mastertable, which defines via a `masterkey' (hmt_id)
-- which binds all component to have a complete HLT configuration
CREATE TABLE hlt_master_table (
  	hmt_id               		NUMBER(10),
  	hmt_name             		VARCHAR2(50),
  	hmt_version          		NUMBER(11),
  	hmt_comment			VARCHAR2(200)	,
  	hmt_trigger_menu_id  		NUMBER(10),
  	hmt_l2_setup_id  		NUMBER(10),
  	hmt_ef_setup_id  		NUMBER(10),
  	hmt_forced_setup_id  		NUMBER(10),
  	hmt_username         		VARCHAR2(50),
  	hmt_modified_time    		TIMESTAMP,
  	hmt_status           		NUMBER(2),
  	hmt_used             		CHAR         		default 0,
  	CONSTRAINT  			hmt_pk       		PRIMARY KEY (hmt_id),
  	CONSTRAINT    			hmt_fk_tm    		FOREIGN KEY (hmt_trigger_menu_id)
                               					REFERENCES hlt_trigger_menu(htm_id),
  	CONSTRAINT 			hmt_fk_l2st   		FOREIGN KEY (hmt_l2_setup_id) 
								REFERENCES hlt_setup(hst_id),
  	CONSTRAINT 			hmt_fk_efst   		FOREIGN KEY (hmt_ef_setup_id) 
								REFERENCES hlt_setup(hst_id),
  	CONSTRAINT    			hmt_nmver    		UNIQUE (hmt_name, hmt_version),
	CONSTRAINT			hmt_id_NN 		CHECK ( hmt_id IS NOT NULL),
	CONSTRAINT			hmt_name_NN 		CHECK ( hmt_name IS NOT NULL),
	CONSTRAINT			hmt_version_NN 		CHECK ( hmt_version IS NOT NULL),
	CONSTRAINT			hmt_status_NN 		CHECK ( hmt_status IS NOT NULL),
	CONSTRAINT			hmt_used_NN 		CHECK ( hmt_used IS NOT NULL)
);
CREATE INDEX hmt_trigger_menu_id_ind ON hlt_master_table(hmt_trigger_menu_id);
CREATE INDEX hmt_l2_setup_id_ind     ON hlt_master_table(hmt_l2_setup_id);
CREATE INDEX hmt_ef_setup_id_ind     ON hlt_master_table(hmt_ef_setup_id);


--This table binds the LVL1 configuration and the HLT configuration to a single key.

CREATE TABLE super_master_table (
  	smt_id                  	NUMBER(10),
  	smt_name                	VARCHAR2(50),
  	smt_version             	NUMBER(11),
  	smt_comment		  	VARCHAR2(200),
  	smt_origin	          	VARCHAR2(50),
  	smt_parent_history_key  	NUMBER(10),
  	smt_l1_master_table_id  	NUMBER(10),
  	smt_hlt_master_table_id 	NUMBER(10),
  	smt_username            	VARCHAR2(50),
  	smt_modified_time       	TIMESTAMP,
  	smt_status              	NUMBER(2),
  	smt_used                	CHAR         		default 0,
  	CONSTRAINT 			smt_pk       		PRIMARY KEY (smt_id),
  	CONSTRAINT 			smt_fk_l1mt  		FOREIGN KEY (smt_l1_master_table_id)
                            					REFERENCES l1_master_table(l1mt_id),
  	CONSTRAINT 			smt_fk_hmt   		FOREIGN KEY (smt_hlt_master_table_id)
  	                          				REFERENCES hlt_master_table(hmt_id),
  	CONSTRAINT 			smt_nmver    		UNIQUE (smt_name, smt_version),
 	CONSTRAINT			smt_id_NN 		CHECK ( smt_id IS NOT NULL),
	CONSTRAINT			smt_name_NN 		CHECK ( smt_name IS NOT NULL),
	CONSTRAINT			smt_version_NN 		CHECK ( smt_version IS NOT NULL),
	CONSTRAINT			smt_l1_master_id_NN 	CHECK ( smt_l1_master_table_id IS NOT NULL),
	CONSTRAINT			smt_hlt_master_id_NN 	CHECK ( smt_hlt_master_table_id IS NOT NULL),
	CONSTRAINT			smt_status_NN 		CHECK ( smt_status IS NOT NULL),
	CONSTRAINT			smt_used_NN 		CHECK ( smt_used IS NOT NULL)
);
CREATE INDEX smt_l1_master_id_ind  ON super_master_table(smt_l1_master_table_id);
CREATE INDEX smt_hlt_master_id_ind ON super_master_table(smt_hlt_master_table_id);


-- Extra link table to relate release table to the supermaster table (one SMkey can work with many releases) 
CREATE TABLE HLT_SMT_TO_HRE (
  	smt2re_id                      	NUMBER(10),
  	smt2re_super_master_table_id   	NUMBER(10),
  	smt2re_release_id              	NUMBER(10),
  	smt2re_username                	VARCHAR2(50),
  	smt2re_modified_time           	TIMESTAMP,
  	smt2re_used                    	CHAR        		default 0,
  	CONSTRAINT 			smt2re_pk           	PRIMARY KEY (smt2re_id),
  	CONSTRAINT 			smt2re_fk_smt       	FOREIGN KEY (smt2re_super_master_table_id)  
								REFERENCES SUPER_MASTER_TABLE(smt_id),
  	CONSTRAINT 			smt2re_fk_re        	FOREIGN KEY (smt2re_release_id)             
								REFERENCES HLT_RELEASE(hre_id),
	CONSTRAINT			smt2re_id_NN 		CHECK ( smt2re_id IS NOT NULL),
	CONSTRAINT			smt2re_used_NN 		CHECK ( smt2re_used IS NOT NULL)
);
CREATE INDEX smt2re_smt_id_ind ON HLT_SMT_TO_HRE(smt2re_super_master_table_id);
CREATE INDEX smt2re_rel_id_ind ON HLT_SMT_TO_HRE(smt2re_release_id);

CREATE TABLE trigger_next_run (
	tnr_id				NUMBER(10),
	tnr_super_master_table_id	NUMBER(10),
	tnr_username 			VARCHAR2(50),
	tnr_modified_time		TIMESTAMP,
	tnr_used			CHAR			default 0,
	CONSTRAINT			tnr_pk 			PRIMARY KEY (tnr_id),
	CONSTRAINT			tnr_fk_smt		FOREIGN KEY (tnr_super_master_table_id)
								REFERENCES super_master_table(smt_id),
	CONSTRAINT			tnr_id_NN 		CHECK ( tnr_id IS NOT NULL),
	CONSTRAINT			tnr_super_master_id_NN 	CHECK ( tnr_super_master_table_id IS NOT NULL),
	CONSTRAINT			tnr_used_NN 		CHECK ( tnr_used IS NOT NULL)
);		
CREATE INDEX tnr_super_master_table_id_ind ON trigger_next_run(tnr_super_master_table_id);


CREATE TABLE trigger_log (
	tlog_username			VARCHAR2(50),
	tlog_short			VARCHAR2(200),
	tlog_message			VARCHAR2(2000),
	tlog_modified_time		TIMESTAMP
);

commit;

--really these are part of the schema, so should go here
INSERT INTO l1_random_rates VALUES(0,"157.2 kHz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(1,"78.4 kHz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(2,"39.2 kHz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(3,"19.6 kHz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(4,"9.8 kHz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(5,"4.9 kHz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(6,"2.4 kHz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(7,"1.2 kHz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(8,"610 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(9,"310 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(10,"150 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(11,"76.4 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(12,"38.2 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(13,"19.1 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(14,"9.6 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(15,"4.8 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(16,"2.4 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(17,"1.2 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(18,"0.60 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(19,"0.30 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(20,"0.15 Hz",INSERTTIME);
INSERT INTO l1_random_rates VALUES(21,"0.07 Hz",INSERTTIME);

commit;
