CREATE TABLE authors (
  author_id serial primary key,
  name text
);

CREATE TABLE posts (
  post_id serial primary key,
  author_id integer,
  body text
);

CREATE TABLE comments (
  comment_id serial primary key,
  post_id integer,
  author_id integer,
  body text
);

CREATE TABLE permissions_test.column_acl (
  column_acl_id serial primary key,
  non_acl_column integer,
  acl_column integer
);


