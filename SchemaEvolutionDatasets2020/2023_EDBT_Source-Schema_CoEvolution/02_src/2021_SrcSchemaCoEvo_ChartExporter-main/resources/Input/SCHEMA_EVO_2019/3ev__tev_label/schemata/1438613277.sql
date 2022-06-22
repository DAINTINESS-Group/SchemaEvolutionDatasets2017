#
# Table structure for table 'tx_tevlabel_labels'
#

CREATE TABLE tx_tevlabel_labels (
	uid int(11) NOT NULL auto_increment,
	pid int(11) DEFAULT '0' NOT NULL,
	tstamp int(11) DEFAULT '0' NOT NULL,
	crdate int(11) DEFAULT '0' NOT NULL,
	cruser_id int(11) DEFAULT '0' NOT NULL,
	deleted tinyint(4) DEFAULT '0' NOT NULL,
	hidden tinyint(4) DEFAULT '0' NOT NULL,
	label_key tinytext NOT NULL,
	label_value text NOT NULL,
	front_end tinyint(4) DEFAULT '0' NOT NULL

	PRIMARY KEY (uid),
	KEY parent (pid)
);
