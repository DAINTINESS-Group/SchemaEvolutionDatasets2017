CREATE TABLE dataset (
    sysid integer NOT NULL,
    id character varying(255),
    publisher character varying(255),
    contact character varying(255),
    description text,
    vers character varying(255),
    category json,
    ckanid character varying(255),
    geobbox character varying(255),
    geotoponym character varying(255)
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

