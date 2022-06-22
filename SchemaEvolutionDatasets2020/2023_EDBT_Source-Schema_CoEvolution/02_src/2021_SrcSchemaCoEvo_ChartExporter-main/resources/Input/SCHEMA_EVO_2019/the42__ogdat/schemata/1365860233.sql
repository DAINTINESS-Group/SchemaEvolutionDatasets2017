CREATE TABLE dataset (
    sysid integer NOT NULL,
    id character varying(255) NOT NULL,
    publisher character varying(255),
    contact character varying(255) NOT NULL,
    description text,
    vers character varying(255) NOT NULL,
    category json
);



CREATE TABLE heartbeat (
    sysid integer NOT NULL,
    ts timestamp with time zone,
    statustext character varying(255),
    fetchtime timestamp with time zone,
    statuscode smallint,
    who uuid NOT NULL
);


CREATE TABLE status (
    sysid integer NOT NULL,
    datasetid integer NOT NULL,
    reason_text text,
    field_id integer,
    hittime timestamp with time zone,
    status varying(20),
    fieldstatus integer
);


