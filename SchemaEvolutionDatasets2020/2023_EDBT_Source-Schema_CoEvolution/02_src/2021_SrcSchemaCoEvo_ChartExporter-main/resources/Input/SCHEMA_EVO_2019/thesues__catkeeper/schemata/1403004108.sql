CREATE TABLE "virtualmachine" ("Id" integer not null primary key autoincrement,"UUIDString" varchar(255), "Owner" varchar(255), "Description" varchar(255));
CREATE TABLE "physicalmachine" ("Id" integer not null primary key autoincrement, "Name" varchar(255),  "IpAddress" varchar(255), "Description" varchar(255));

