CREATE TABLE actions (	    id              numeric NOT NULL,
	    name            character varying(2048) NOT NULL,
	    target          character varying(2048) NOT NULL,
	    description     json,
	    threat          json,
	    operations      json,
	    validfrom       timestamp with time zone NOT NULL,
	    expireafter     timestamp with time zone NOT NULL,
	    starttime       timestamp with time zone,
	    finishtime      timestamp with time zone,
	    lastupdatetime  timestamp with time zone,
	    status          character varying(256),
	    syntaxversion   integer,
	    pgpsignatures   character varying(4096) NOT NULL	);

CREATE TABLE agents (	    id                  numeric NOT NULL,
	    name                character varying(2048) NOT NULL,
	    queueloc            character varying(2048) NOT NULL,
	    mode                character varying(2048) NOT NULL,
	    version             character varying(2048) NOT NULL,
	    pid                 integer NOT NULL,
	    starttime           timestamp with time zone NOT NULL,
	    destructiontime     timestamp with time zone,
	    heartbeattime       timestamp with time zone NOT NULL,
	    refreshtime         timestamp with time zone NOT NULL,
	    status              character varying(255),
	    environment         json,
	    tags                json	);

CREATE TABLE agents_stats (	    timestamp                   timestamp with time zone not null,
	    online_agents               numeric,
	    online_agents_by_version    json,
	    online_endpoints            numeric,
	    idle_agents                 numeric,
	    idle_agents_by_version      json,
	    idle_endpoints              numeric,
	    new_endpoints               numeric,
	    multi_agents_endpoints      numeric,
	    disappeared_endpoints       numeric,
	    flapping_endpoints          numeric	);

CREATE TABLE agtmodreq (	    moduleid        numeric NOT NULL,
	    agentid         numeric NOT NULL,
	    minimumweight   integer NOT NULL	);

CREATE TABLE commands (	    id          numeric NOT NULL,
	    actionid    numeric NOT NULL,
	    agentid     numeric NOT NULL,
	    status      character varying(255) NOT NULL,
	    results     json,
	    starttime   timestamp with time zone NOT NULL,
	    finishtime  timestamp with time zone	);

CREATE TABLE invagtmodperm (	    investigatorid  numeric NOT NULL,
	    agentid         numeric NOT NULL,
	    moduleid        numeric NOT NULL,
	    weight          integer NOT NULL	);

CREATE TABLE investigators (	    id              numeric NOT NULL DEFAULT nextval('investigators_id_seq'),
	    name            character varying(1024) NOT NULL,
	    pgpfingerprint  character varying(128),
	    publickey       bytea,
	    privatekey      bytea,
	    status          character varying(255) NOT NULL,
	    createdat       timestamp with time zone NOT NULL,
	    lastmodified    timestamp with time zone NOT NULL,
	    isadmin         boolean NOT NULL DEFAULT false	);

CREATE TABLE manifests (	id        numeric NOT NULL DEFAULT nextval('manifests_id_seq'),
	name      character varying(256) NOT NULL,
	content   text NOT NULL,
	timestamp timestamp with time zone NOT NULL,
	status    character varying(255) NOT NULL,
	target    character varying(2048) NOT NULL	);

CREATE TABLE manifestsig (	manifestid     numeric NOT NULL,
	investigatorid numeric NOT NULL,
	pgpsignature   character varying(4096) NOT NULL	);

CREATE TABLE loaders (	id         numeric NOT NULL DEFAULT nextval('loaders_id_seq'),
	loadername character varying(256) NOT NULL,
	loaderkey  character varying(64) NOT NULL,
	name       character varying(2048),
	env        json,
	tags       json	);

CREATE TABLE modules (	    id      numeric NOT NULL,
	    name    character varying(256) NOT NULL	);

CREATE TABLE signatures (	    actionid        numeric NOT NULL,
	    investigatorid  numeric NOT NULL,
	    pgpsignature    character varying(4096) NOT NULL	);

