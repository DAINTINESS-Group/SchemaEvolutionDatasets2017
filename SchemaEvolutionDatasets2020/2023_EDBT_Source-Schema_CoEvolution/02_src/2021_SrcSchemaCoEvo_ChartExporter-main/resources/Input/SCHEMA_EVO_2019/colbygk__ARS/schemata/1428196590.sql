
drop table if exists flights;
drop table if exists airports;


create table airports (
    id int not null auto_increment primary key,
    short_name varchar(25) not null,
    long_name  varchar(100) not null
    ) engine=InnoDB;

create table flights (
    id int not null auto_increment primary key,
    id_str varchar(25) not null,
    depart_airport int not null,
    depart_time datetime not null,
    arrive_airport int not null,
    arrive_time datetime not null,
    foreign key fk_depart_airport(depart_airport) references airports(id),
    foreign key fk_arrive_airport(arrive_airport) references airports(id)
    ) engine=InnoDB;


/* The following insert statements were autogenerated by the
   convert_json_to_sql.js script in ../web */
