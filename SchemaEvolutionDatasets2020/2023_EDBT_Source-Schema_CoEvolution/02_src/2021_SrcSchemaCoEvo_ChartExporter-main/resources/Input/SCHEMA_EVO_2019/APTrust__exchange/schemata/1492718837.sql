-- audit_db_schema.sql
--
-- This defines the schema for a SQLite database used
-- to audit our S3 and Glacier files.
--
-- To run this:
--
-- sqlite3 audit.db < audit_db_schema.sql
--
-- Data for the stored_files table comes from the
-- apt_audit_list program in the apps directory.
--
-- Data for pharos_files comes from Pharos (see the README
-- for the actual code).
--
-- Data for fixed_files will come from the code we use to
-- copy good Glacier files over bad S3 files.
--
create table if not exists stored_files (
    id integer primary key,
    uuid varchar(36) not null,
    bucket varchar(80) not null,
    size bigint not null default 0,
    content_type varchar(80),
    institution varchar(40),
    bag_name varchar(255),
    path_in_bag varchar(400),
    md5 varchar(32),
    sha256 varchar(64),
    etag varchar(64) not null,
    last_modified datetime not null,
    last_seen_at datetime,
    deleted_at datetime,
    created_at datetime,
    updated_at datetime );

create table if not exists pharos_files (
    identifier varchar(255),
    uuid varchar(36),
    size bigint,
    deleted bool not null default false,
    created_at datetime,
    updated_at datetime );

create table if not exists fixed_files (
    identifier varchar(255),
    uuid varchar(36),
    from_url varchar(255),
    to_url varchar(255),
    copy_started_at datetime,
    copy_completed_at datetime);

create index if not exists ix_stored_uuid on stored_files(uuid);
create index if not exists ix_stored_ident on stored_files(bag_name, path_in_bag);
create index if not exists ix_pharos_uuid on pharos_files(uuid);
create index if not exists ix_pharos_ident on pharos_files(identifier);
create index if not exists ix_fixed_uuid on fixed_files(uuid);
create index if not exists ix_fixed_ident on fixed_files(identifier);
