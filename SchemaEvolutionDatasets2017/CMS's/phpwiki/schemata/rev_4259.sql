-- $Id: mysql-initialize.sql,v 1.4 2004-12-10 02:45:27 rurban Exp $

CREATE TABLE page (
	id              INT NOT NULL AUTO_INCREMENT,
        pagename        VARCHAR(100) BINARY NOT NULL,
	hits            INT NOT NULL DEFAULT 0,
        pagedata        MEDIUMTEXT NOT NULL DEFAULT '',
-- dont add that by hand, better let action=upgrade convert your data
	cached_html 	MEDIUMBLOB,
        PRIMARY KEY (id),
	UNIQUE KEY (pagename)
);

CREATE TABLE version (
	id              INT NOT NULL,
        version         INT NOT NULL,
	mtime           INT NOT NULL,
	minor_edit      TINYINT DEFAULT 0,
        content         MEDIUMTEXT NOT NULL DEFAULT '',
        versiondata     MEDIUMTEXT NOT NULL DEFAULT '',
        PRIMARY KEY (id,version),
	INDEX (mtime)
);

CREATE TABLE recent (
	id              INT NOT NULL,
	latestversion   INT,
	latestmajor     INT,
	latestminor     INT,
        PRIMARY KEY (id)
);

CREATE TABLE nonempty (
	id              INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE link (
	linkfrom        INT NOT NULL,
        linkto          INT NOT NULL,
	INDEX (linkfrom),
        INDEX (linkto)
);

CREATE TABLE session (
    	sess_id 	CHAR(32) NOT NULL DEFAULT '',
    	sess_data 	BLOB NOT NULL,
    	sess_date 	INT UNSIGNED NOT NULL,
    	sess_ip 	CHAR(15) NOT NULL,
    	PRIMARY KEY (sess_id),
	INDEX (sess_date)
); -- TYPE=heap; -- if your Mysql supports it and you have enough RAM

-- upgrade to 1.3.8: (see lib/upgrade.php)
-- ALTER TABLE session ADD sess_ip CHAR(15) NOT NULL;
-- CREATE INDEX sess_date on session (sess_date);
-- update to 1.3.10: (see lib/upgrade.php)
-- ALTER TABLE page CHANGE id id INT NOT NULL AUTO_INCREMENT;

-- Optional DB Auth and Prefs
-- For these tables below the default table prefix must be used 
-- in the DBAuthParam SQL statements also.

CREATE TABLE pref (
  	userid 	CHAR(48) BINARY NOT NULL UNIQUE,
  	prefs  	TEXT NULL DEFAULT '',
  	PRIMARY KEY (userid)
) TYPE=MyISAM;

-- better use the extra pref table where such users can be created easily 
-- without password.
CREATE TABLE user (
  	userid 	CHAR(48) BINARY NOT NULL UNIQUE,
  	passwd 	CHAR(48) BINARY DEFAULT '',
--	prefs  	TEXT NULL DEFAULT '',
--	groupname CHAR(48) BINARY DEFAULT 'users',
  	PRIMARY KEY (userid)
) TYPE=MyISAM;

CREATE TABLE member (
	userid    CHAR(48) BINARY NOT NULL,
   	groupname CHAR(48) BINARY NOT NULL DEFAULT 'users',
   	INDEX (userid),
   	INDEX (groupname)
) TYPE=MyISAM;

-- only if you plan to use the wikilens theme
CREATE TABLE rating (
        dimension INT(4) NOT NULL,
        raterpage INT(11) NOT NULL,
        rateepage INT(11) NOT NULL,
        ratingvalue FLOAT NOT NULL,
        rateeversion INT(11) NOT NULL,
        tstamp TIMESTAMP(14) NOT NULL,
        PRIMARY KEY (dimension, raterpage, rateepage)
);

-- only if you need fast log-analysis (spam prevention, recent referrers)
-- see http://www.outoforder.cc/projects/apache/mod_log_sql/docs-2.0/#id2756178
CREATE TABLE accesslog (
        time_stamp    int unsigned,
	remote_host   varchar(50),
	remote_user   varchar(50),
        request_method varchar(10),
	request_line  varchar(255),
	request_args  varchar(255),
	request_file  varchar(255),
	request_uri   varchar(255),
	request_time  char(28),
	status 	      smallint unsigned,
	bytes_sent    smallint unsigned,
        referer       varchar(255), 
	agent         varchar(255),
	request_duration float
);
CREATE INDEX log_time ON accesslog (time_stamp);
CREATE INDEX log_host ON accesslog (remote_host);
