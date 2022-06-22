CREATE TABLE IF NOT EXISTS "account_data" (
	"user_id" SERIAL PRIMARY KEY,
	"username" TEXT NOT NULL,
	"password" BYTEA NOT NULL,
	"salt" BYTEA NOT NULL,
	"algorithm" TEXT NOT NULL,
	"createdon" TIMESTAMP NOT NULL,
	"lastlogin" TIMESTAMP NOT NULL
);
DELETE FROM machines;
DROP TABLE machines_metadata;
DROP TABLE machines;

CREATE TABLE IF NOT EXISTS "machines" (
	"machine_id" SERIAL PRIMARY KEY,
	"remote_address" TEXT,
	"service_listen_port" INTEGER
);
DROP TABLE "characters";

CREATE TABLE "characters" (
	"id" SERIAL PRIMARY KEY,
	"uid" INTEGER references account_data(user_id),
	"name" TEXT,
	"game_data" JSON,
	"last_game_id" INTEGER DEFAULT 0
);

DROP TABLE "game_servers";
DROP TABLE "games";


CREATE TABLE IF NOT EXISTS "games" (
	"game_id" SERIAL PRIMARY KEY,
	"map_name" TEXT NOT NULL,
	"game_mode" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "game_servers" (
	"game_id" SERIAL PRIMARY KEY references games(game_id),
	"machine_id" SERIAL references machines(machine_id),
	"port" INTEGER
);




CREATE TABLE IF NOT EXISTS "machines_metadata" (
	"machine_id" INTEGER PRIMARY KEY references machines(machine_id) ,
	"most_recent_key" TEXT,
	"last_heartbeat" TIMESTAMP,
	"cpu_usage_pct" REAL,
	"network_usage_pct" REAL,
	"player_occupancy_pct" REAL
);
