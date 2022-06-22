CREATE TABLE users (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    password text NOT NULL,
	    serverkey varchar(64) NOT NULL DEFAULT '',
	    salt varchar(64) NOT NULL DEFAULT '',
	    iterationcount integer NOT NULL DEFAULT 0,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	    PRIMARY KEY (server_host(191),
 username)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE last (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    seconds text NOT NULL,
	    state text NOT NULL,
	    PRIMARY KEY (server_host(191),
 username)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE rosterusers (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    jid varchar(191) NOT NULL,
	    nick text NOT NULL,
	    subscription character(1) NOT NULL,
	    ask character(1) NOT NULL,
	    askmessage text NOT NULL,
	    server character(1) NOT NULL,
	    subscribe text NOT NULL,
	    type text,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE rostergroups (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    jid varchar(191) NOT NULL,
	    grp text NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE sr_group (	    name varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    opts text NOT NULL,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	    PRIMARY KEY (server_host(191),
 name)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE sr_user (	    jid varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    grp varchar(191) NOT NULL,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	    PRIMARY KEY (server_host(191),
 jid,
 grp)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE spool (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    xml mediumtext NOT NULL,
	    seq BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE archive (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    timestamp BIGINT UNSIGNED NOT NULL,
	    peer varchar(191) NOT NULL,
	    bare_peer varchar(191) NOT NULL,
	    xml mediumtext NOT NULL,
	    txt mediumtext,
	    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	    kind varchar(10),
	    nick varchar(191),
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE archive_prefs (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    def text NOT NULL,
	    always text NOT NULL,
	    never text NOT NULL,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	    PRIMARY KEY (server_host(191),
 username)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE vcard (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    vcard mediumtext NOT NULL,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	    PRIMARY KEY (server_host(191),
 username)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE vcard_search (	    username varchar(191) NOT NULL,
	    lusername varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    fn text NOT NULL,
	    lfn varchar(191) NOT NULL,
	    family text NOT NULL,
	    lfamily varchar(191) NOT NULL,
	    given text NOT NULL,
	    lgiven varchar(191) NOT NULL,
	    middle text NOT NULL,
	    lmiddle varchar(191) NOT NULL,
	    nickname text NOT NULL,
	    lnickname varchar(191) NOT NULL,
	    bday text NOT NULL,
	    lbday varchar(191) NOT NULL,
	    ctry text NOT NULL,
	    lctry varchar(191) NOT NULL,
	    locality text NOT NULL,
	    llocality varchar(191) NOT NULL,
	    email text NOT NULL,
	    lemail varchar(191) NOT NULL,
	    orgname text NOT NULL,
	    lorgname varchar(191) NOT NULL,
	    orgunit text NOT NULL,
	    lorgunit varchar(191) NOT NULL,
	    PRIMARY KEY (server_host(191),
 lusername)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE privacy_default_list (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    name varchar(191) NOT NULL,
	    PRIMARY KEY (server_host(191),
 username)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE privacy_list (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    name varchar(191) NOT NULL,
	    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE privacy_list_data (	    id bigint,
	    t character(1) NOT NULL,
	    value text NOT NULL,
	    action character(1) NOT NULL,
	    ord NUMERIC NOT NULL,
	    match_all boolean NOT NULL,
	    match_iq boolean NOT NULL,
	    match_message boolean NOT NULL,
	    match_presence_in boolean NOT NULL,
	    match_presence_out boolean NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE private_storage (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    namespace varchar(191) NOT NULL,
	    data text NOT NULL,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	    PRIMARY KEY (server_host(191),
 username,
 namespace)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE roster_version (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    version text NOT NULL,
	    PRIMARY KEY (server_host(191),
 username)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE pubsub_node (	  host text NOT NULL,
	  node text NOT NULL,
	  parent VARCHAR(191) NOT NULL DEFAULT '',
	  plugin text NOT NULL,
	  nodeid bigint auto_increment primary key	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE pubsub_node_option (	  nodeid bigint,
	  name text NOT NULL,
	  val text NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE pubsub_node_owner (	  nodeid bigint,
	  owner text NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE pubsub_state (	  nodeid bigint,
	  jid text NOT NULL,
	  affiliation character(1),
	  subscriptions VARCHAR(191) NOT NULL DEFAULT '',
	  stateid bigint auto_increment primary key	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE pubsub_item (	  nodeid bigint,
	  itemid text NOT NULL,
	  publisher text NOT NULL,
	  creation varchar(32) NOT NULL,
	  modification varchar(32) NOT NULL,
	  payload text NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE pubsub_subscription_opt (	  subid text NOT NULL,
	  opt_name varchar(32),
	  opt_value text NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE muc_room (	    name text NOT NULL,
	    host text NOT NULL,
	    server_host text NOT NULL,
	    opts mediumtext NOT NULL,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE muc_registered (	    jid text NOT NULL,
	    host text NOT NULL,
	    server_host text NOT NULL,
	    nick text NOT NULL,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE muc_online_room (	    name text NOT NULL,
	    host text NOT NULL,
	    server_host text NOT NULL,
	    node text NOT NULL,
	    pid text NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE muc_online_users (	    username text NOT NULL,
	    server text NOT NULL,
	    resource text NOT NULL,
	    name text NOT NULL,
	    host text NOT NULL,
	    server_host text NOT NULL,
	    node text NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE muc_room_subscribers (	   room varchar(191) NOT NULL,
	   host varchar(191) NOT NULL,
	   jid varchar(191) NOT NULL,
	   nick text NOT NULL,
	   nodes text NOT NULL,
	   created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  UNIQUE KEY i_muc_room_subscribers_host_room_jid (host,
 room,
 jid)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE motd (	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    xml text,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	    PRIMARY KEY (server_host(191),
 username)	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE caps_features (	    node varchar(191) NOT NULL,
	    subnode varchar(191) NOT NULL,
	    feature text,
	    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE sm (	    usec bigint NOT NULL,
	    pid text NOT NULL,
	    node text NOT NULL,
	    username varchar(191) NOT NULL,
	    server_host text NOT NULL,
	    resource varchar(191) NOT NULL,
	    priority text NOT NULL,
	    info text NOT NULL,
	    PRIMARY KEY (usec,
 pid(75))	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE oauth_token (	    token varchar(191) NOT NULL PRIMARY KEY,
	    jid text NOT NULL,
	    scope text NOT NULL,
	    expire bigint NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE route (	    domain text NOT NULL,
	    server_host text NOT NULL,
	    node text NOT NULL,
	    pid text NOT NULL,
	    local_hint text NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE bosh (	    sid text NOT NULL,
	    node text NOT NULL,
	    pid text NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE carboncopy (	    username text NOT NULL,
	    server_host text NOT NULL,
	    resource text NOT NULL,
	    namespace text NOT NULL,
	    node text NOT NULL,
	    PRIMARY KEY (server_host(191),
 username(191),
 resource(191))	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE proxy65 (	    sid text NOT NULL,
	    pid_t text NOT NULL,
	    pid_i text NOT NULL,
	    node_t text NOT NULL,
	    node_i text NOT NULL,
	    jid_i text NOT NULL	) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE push_session (	    username text NOT NULL,
	    server_host text NOT NULL,
	    timestamp bigint NOT NULL,
	    service text NOT NULL,
	    node text NOT NULL,
	    xml text NOT NULL,
	    PRIMARY KEY (server_host(191),
 username(191),
 timestamp)	);

