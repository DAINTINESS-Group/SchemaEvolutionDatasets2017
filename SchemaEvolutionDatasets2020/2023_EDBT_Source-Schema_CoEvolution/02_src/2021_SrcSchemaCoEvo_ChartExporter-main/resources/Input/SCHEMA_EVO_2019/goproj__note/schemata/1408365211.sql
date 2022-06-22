use todo_note;

set names utf8;

/*user*/
drop table if exists user;
create table user(
  id int unsigned primary key auto_increment,
  name varchar(64) not null unique comment 'use email if user not specified',
  email varchar(64) not null unique,
  password varchar(64),
  portrait varchar(255) comment 'from avatar',
  blocked tinyint(1) not null default 0,
  create_at datetime not null
)ENGINE=innodb DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


/*note*/
drop table if exists note;
create table note(
  id int unsigned primary key auto_increment,
  user_id int unsigned not null,
  content varchar(1024) not null,
  done tinyint(1) not null default 0,
  done_at datetime,
  create_at datetime not null,
  key idx_note_user_id (user_id)
)ENGINE=innodb DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
