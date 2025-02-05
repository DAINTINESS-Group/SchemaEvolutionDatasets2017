CREATE TABLE users (
    oid INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    eid CHAR(64) CHARACTER SET latin1 NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nickname TEXT NOT NULL,
    email TEXT,
    tshirt_size CHAR(4) CHARACTER SET latin1 NOT NULL DEFAULT 'M',
    created_on DATETIME NOT NULL,
    modified_on TIMESTAMP NOT NULL ON UPDAte CURRENT_TIMESTAMP,
    KEY(eid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE venues (
    oid INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    eid CHAR(64) CHARACTER SET latin1 NOT NULL,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    created_on DATETIME NOT NULL,
    modified_on TIMESTAMP NOT NULL ON UPDAte CURRENT_TIMESTAMP,
    KEY(eid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE rooms (
    oid INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    venue_id CHAR(64) CHARACTER SET latin1 NOT NULL,
    eid CHAR(64) CHARACTER SET latin1 NOT NULL,
    name TEXT NOT NULL,
    capacity INT UNSIGNED NOT NULL DEFAULT 0,
    created_on DATETIME NOT NULL,
    modified_on TIMESTAMP NOT NULL ON UPDAte CURRENT_TIMESTAMP,
    KEY(venue_id, eid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE localized_strings (
    oid INTEGER UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    parent_id CHAR(64) CHARACTER SET latin1 NOT NULL,
    parent_type CHAR(64) CHARACTER SET latin1 NOT NULL,
    name CHAR(250) BINARY NOT NULL,
    language CHAR(32) BINARY NOT NULL,
    localized TEXT NOT NULL,
    KEY (parent_id, parent_type, name, language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;