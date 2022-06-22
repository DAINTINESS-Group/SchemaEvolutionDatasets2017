CREATE TABLE public.eventlog
("id" serial,
"timestamp" int4 NOT NULL,
local_ts int4 NOT NULL,
"level" int4,
details varchar(100),
"label" varchar(25) NOT NULL,
env varchar(4),
pid int4,
app varchar(10) NOT NULL,
"version" varchar(9),
component varchar(18) NOT NULL,
"host" varchar(60),
PRIMARY KEY ("timestamp", local_ts, "label", env, app, component))