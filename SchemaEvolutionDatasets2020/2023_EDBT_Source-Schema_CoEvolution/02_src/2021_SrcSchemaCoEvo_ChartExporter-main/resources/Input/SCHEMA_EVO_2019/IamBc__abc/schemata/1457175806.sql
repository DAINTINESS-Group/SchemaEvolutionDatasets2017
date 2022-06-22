

CREATE TABLE image_board_clusters(id serial primary key,
                                  name text not null,
                                  descr text not null,
                                  long_descr text,
                                  api_key text not null default,
                                  board_limit_count INT NOT NULL default 99999
                                  );

CREATE TABLE thread_limits_reached_actions(
                                            id serial primary key,
                                            name text not null,
                                            descr text
);

INSERT INTO thread_limits_reached_actions VALUES(1, 'archive', 'Thread will not be displayed, but present in the admin panel.'); 
INSERT INTO thread_limits_reached_actions VALUES(2, 'delete', 'Thread will be deleted.'); 
INSERT INTO thread_limits_reached_actions VALUES(3, 'read_only', 'Thread will be displayed but users will not be able to post in it.'); 

CREATE TABLE boards(id serial primary key,
                    name text not null,
                    descr text,
                    image_board_cluster_id INT REFERENCES image_board_clusters,
                    thread_setting_max_thread_count INT NOT NULL default -1,
                    thread_setting_max_active_thread_count int not null default -1,
                    thread_setting_max_posts_per_thread INT NOT NULL default 999999,
                    thread_setting_are_attachments_allowed BOOLEAN NOT NULL DEFAULT FALSE,
                    thread_setting_limits_reached_action_id INT REFERENCES thread_limits_reached_actions
                    );
-- Board total posts count ?
-- Board total attachments count ? 
-- Max views ? 
-- Time expires at
-- Date expires at

CREATE TABLE threads(   id serial primary key,
                        name text not null,
                        board_id INT REFERENCES boards,
                        max_posts_per_thread INT NOT NULL default 999999,
                        are_attachments_allowed BOOLEAN NOT NULL DEFAULT FALSE,
                        limits_reached_action_id INT REFERENCES thread_limits_reached_actions,
                        is_active boolean not null default true
                    );

CREATE TABLE thread_posts(id serial primary key,
                          body text not null,
                          thread_id INT REFERENCES threads,
                          attachment_url TEXT,
                          inserted_at timestamp with timezone not null default now(),
                          source_ip TEXT);
                          -- todo limits);
