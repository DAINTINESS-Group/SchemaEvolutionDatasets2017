
CREATE TABLE "games" (
	"game_id" SERIAL PRIMARY KEY,
	"map_name" TEXT NOT NULL,
	"game_mode" TEXT NOT NULL,
	"minimum_level" INTEGER DEFAULT 0,
	"player_count" INTEGER DEFAULT 0,
	"maximum_players" INTEGER DEFAULT 16
);

CREATE TABLE "account_data" (
	"user_id" SERIAL PRIMARY KEY,
	"username" TEXT NOT NULL,
	"password" BYTEA NOT NULL,
	"salt" BYTEA NOT NULL,
	"algorithm" TEXT NOT NULL,
	"createdon" TIMESTAMP NOT NULL,
	"lastlogin" TIMESTAMP NOT NULL
);

CREATE TABLE "characters" (
	"id" SERIAL PRIMARY KEY,
	"uid" INTEGER references account_data(user_id),
	"name" TEXT,
	"game_data" JSON,
	"last_game_id" INTEGER DEFAULT 0
);


CREATE TABLE "machines" (
	"machine_id" SERIAL PRIMARY KEY,
	"remote_address" TEXT,
	"service_listen_port" INTEGER
);

CREATE TABLE "machines_metadata" (
	"machine_id" INTEGER PRIMARY KEY references machines(machine_id) ,
	"most_recent_key" TEXT,
	"last_heartbeat" TIMESTAMP,
	"cpu_usage_pct" REAL,
	"network_usage_pct" REAL,
	"player_occupancy_pct" REAL
);

CREATE TABLE "loading_hosts" (
	"game_id" SERIAL PRIMARY KEY references games(game_id) ,
	"machine_id" SERIAL references machines(machine_id) ,
	"kickoff_time" TIMESTAMP
);

CREATE TABLE "hosts" (
	"game_id" SERIAL PRIMARY KEY references games(game_id),
	"machine_id" SERIAL references machines(machine_id) ,
	"port" INTEGER
);

