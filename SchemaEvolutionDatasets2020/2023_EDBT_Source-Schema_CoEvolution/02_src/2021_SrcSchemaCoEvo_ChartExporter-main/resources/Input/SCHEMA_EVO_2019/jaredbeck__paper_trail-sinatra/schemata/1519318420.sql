/*
Run me with:

sqlite3 db/test.sqlite3
.read spec/create_db.sql

Discussion: Should we set up up rake so we can use normal AR migrations?
We don't need to test against other RDBMS, sqlite is fine. Still, migrations
provide some convenient methods.
*/

drop table if exists versions;
drop table if exists widgets;

create table versions (
  id integer primary key,
  item_type varchar,
  item_id integer not null,
  event varchar not null,
  whodunnit varchar,
  object varchar,
  object_changes varchar,
  transaction_id integer,
  created_at datetime,
  ip varchar,
  user_agent varchar
);

create table widgets (
  id integer primary key,
  name varchar
);
