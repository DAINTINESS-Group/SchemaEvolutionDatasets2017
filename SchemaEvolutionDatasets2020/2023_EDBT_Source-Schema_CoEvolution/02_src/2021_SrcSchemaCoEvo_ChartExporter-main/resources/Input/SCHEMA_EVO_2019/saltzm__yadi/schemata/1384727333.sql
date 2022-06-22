
DROP DATABASE IF EXISTS twitter;
DROP TABLE IF EXISTS tuser cascade;
DROP TABLE IF EXISTS tweet cascade;
DROP TABLE IF EXISTS hashTag cascade;
DROP TABLE IF EXISTS taginTweet cascade;
DROP TABLE IF EXISTS mention cascade;
DROP TABLE IF EXISTS follower cascade;
DROP SEQUENCE IF EXISTS u_id_seq CASCADE;
DROP SEQUENCE IF EXISTS t_id_seq CASCADE;


DROP DATABASE IF EXISTS cinema;
DROP TABLE IF EXISTS movie cascade;
DROP TABLE IF EXISTS featuring cascade;

DROP USER yadi_user;

CREATE USER yadi_user SUPERUSER;

CREATE Database twitter WITH OWNER=yadi_user;
\connect twitter

set role yadi_user;
CREATE SEQUENCE u_id_seq;

CREATE TABLE IF NOT EXISTS tuser 
(
  _0 bigint PRIMARY KEY default nextval('u_id_seq'),   
  _1 character varying(30) UNIQUE NOT NULL,
  _2 character varying(10) NOT NULL,
  _3 character varying(15) NOT NULL
);

CREATE SEQUENCE t_id_seq;

CREATE TABLE  IF NOT EXISTS tweet
(
  _0 bigint PRIMARY KEY default nextval('t_id_seq'),
  _1 character varying(80),
  _2 timestamp(2) without time zone,
  _3 bigint REFERENCES tuser (_0),
  CONSTRAINT datetime_constraint CHECK (_2 < now())
);


CREATE TABLE  IF NOT EXISTS hashTag
(
  _0 bigserial PRIMARY KEY,
  _1 character varying(50) UNIQUE NOT NULL
);

CREATE TABLE  IF NOT EXISTS taginTweet
(
  _0 bigint NOT NULL REFERENCES hashTag (_0),
  _1 bigint NOT NULL REFERENCES tweet (_0),
  PRIMARY KEY(_0,_1)
);


CREATE TABLE IF NOT EXISTS mention
(
  _0 bigint NOT NULL REFERENCES tweet (_0),
  _1 bigint NOT NULL REFERENCES tuser (_0),
  PRIMARY KEY(_0,_1)  
);


CREATE TABLE IF NOT EXISTS follower
(
  _0 bigint NOT NULL REFERENCES tuser (_0),
  _1 bigint NOT NULL REFERENCES tuser (_0),
  PRIMARY KEY(_0,_1)
);

INSERT INTO tuser(_1, _2, _3) VALUES ('francisco','francisco', 'Lyon');
INSERT INTO tuser(_1, _2, _3) VALUES ('matthew','matthew', 'Lyon');
INSERT INTO tuser(_1, _2, _3) VALUES ('nishara','nishara', 'Paris');
INSERT INTO tuser(_1, _2, _3) VALUES ('jorge','jorge', 'Paris');
INSERT INTO tuser(_1, _2, _3) VALUES ('manuel','manuel', 'Nantes');
INSERT INTO tuser(_1, _2, _3) VALUES ('caio','caio', 'Nantes');
INSERT INTO tuser(_1, _2, _3) VALUES ('user7','user7', 'geotag7');
INSERT INTO tuser(_1, _2, _3) VALUES ('user8','user8', 'geotag8');
INSERT INTO tuser(_1, _2, _3) VALUES ('user9','user9', 'geotag9');
INSERT INTO tuser(_1, _2, _3) VALUES ('user10','user10', 'geotag10');

INSERT INTO tweet(_1, _2, _3) VALUES ('working on ADB','2013-10-15 08:00:00',1);
INSERT INTO tweet(_1, _2, _3) VALUES ('@nishara yeah me too','2013-10-15 09:00:00',2);
INSERT INTO tweet(_1, _2, _3) VALUES ('Hello..how are you guys?','2013-10-16 08:00:00',3);
INSERT INTO tweet(_1, _2, _3) VALUES ('working on ADB','2013-10-16 10:00:00',4);
INSERT INTO tweet(_1, _2, _3) VALUES ('Feeling awesome..in #Nantes','2013-10-17 11:00:00',5);
INSERT INTO tweet(_1, _2, _3) VALUES ('@jorge Hellooo..','2013-10-17 14:00:00',3);
INSERT INTO tweet(_1, _2, _3) VALUES ('New to tweet','2013-10-18 09:00:00',6);
INSERT INTO tweet(_1, _2, _3) VALUES ('@user6 welcome to tweeter','2013-10-18 10:00:00',4);
INSERT INTO tweet(_1, _2, _3) VALUES ('Studying for the #exam.','2013-10-20 08:00:00',7);
INSERT INTO tweet(_1, _2, _3) VALUES ('I am on Twitter','2013-10-21 09:00:00',8);


INSERT INTO follower VALUES (1, 2);
INSERT INTO follower VALUES (1, 4);
INSERT INTO follower VALUES (1, 8);
INSERT INTO follower VALUES (2, 1);
INSERT INTO follower VALUES (2, 4);
INSERT INTO follower VALUES (4, 9);
INSERT INTO follower VALUES (2, 5);
INSERT INTO follower VALUES (3, 2);
INSERT INTO follower VALUES (3, 10);
INSERT INTO follower VALUES (6, 7);
INSERT INTO follower VALUES (8, 4);
INSERT INTO follower VALUES (5, 9);


INSERT INTO hashtag VALUES (1, 'Nantes');
INSERT INTO hashtag VALUES (2, 'exam');
INSERT INTO hashtag VALUES (3, 'project');

INSERT INTO tagintweet VALUES (1, 5);
INSERT INTO tagintweet VALUES (2, 9);

INSERT INTO mention VALUES (2, 1);
INSERT INTO mention VALUES (6, 2);
INSERT INTO mention VALUES (8, 6);



CREATE DATABASE cinema WITH OWNER=yadi_user;
\connect cinema

CREATE TABLE movie (
    _0 character varying(30) PRIMARY KEY,
    _1 character varying(30) NOT NULL,
    _2 bigint NOT NULL,
    _3 bigint
);

CREATE TABLE featuring (
    _0 character varying(30) NOT NULL,
    _1 character varying(30) NOT NULL,
    _2 character varying(15) NOT NULL,
    PRIMARY KEY(_0,_1)
);


INSERT INTO movie VALUES ('Home Alone', 'Chris Columbus', 103, 1990);
INSERT INTO movie VALUES ('Life Is Beautiful', 'Roberto Benigni', 116, 1997);
INSERT INTO movie VALUES ('Casino', 'Martin Scorsese', 178, 1995);
INSERT INTO movie VALUES ('Toy Story', 'John Lasseter', 81, 1995);
INSERT INTO movie VALUES ('No Country for Old Men', 'Ethan Coen', 122, 2007);


INSERT INTO featuring VALUES ('Home Alone', 'Macaulay Culkin', 'Kevin');
INSERT INTO featuring VALUES ('Life Is Beautiful', 'Roberto Benigni', 'Guido');
INSERT INTO featuring VALUES ('Casino', 'Robert De Niro', 'Sam');
INSERT INTO featuring VALUES ('Toy Story', 'Hom Hanks', 'Woody');
INSERT INTO featuring VALUES ('No Country for Old Men', 'Tommy Lee Jones', 'Ed Tom Bell');
