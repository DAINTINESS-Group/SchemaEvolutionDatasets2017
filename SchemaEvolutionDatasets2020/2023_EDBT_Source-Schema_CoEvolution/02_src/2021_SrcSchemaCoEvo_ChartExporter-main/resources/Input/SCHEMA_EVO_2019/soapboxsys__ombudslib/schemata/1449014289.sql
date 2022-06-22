-- DB Schema -- Version 0.2.0

CREATE TABLE blocks (
    hash        TEXT NOT NULL, 
    prevhash    TEXT NOT NULL, 
    height      INT,        -- The number of blocks between this one and the genesis block.
    timestamp   INT,        -- The timestamp stored as an epoch time
    -- Extra fields added to reproduce hash of block
    version     INT,
    merkleroot  TEXT,
    difficulty  INT,        -- uint32
    nonce       INT,        -- uint32

    PRIMARY KEY(hash)
    FOREIGN KEY (prevhash) REFERENCES blocks(hash)
);

CREATE TABLE bulletins (
    txid        TEXT NOT NULL, 
    author      TEXT NOT NULL,  -- From the address of the first OutPoint used.
    message     TEXT NOT NULL,  -- UTF-8, must have some content.
    timestamp   INT,            -- Seconds since Jan 1, 1970
    latitude    INT,            -- Fixed point decimal. Divided by 1,000,000 to produce position
    longitude   INT,            -- See above

    block       TEXT,

    PRIMARY KEY(txid), 
    FOREIGN KEY(block) REFERENCES blocks(hash)
);

-- The point of the blacklist is to highlight the fact that editorial control is still possible,
-- but now the choice is given explicity to the third party.
create TABLE blacklist ( 
    txid    TEXT,
    reason  TEXT NOT NULL,

    PRIMARY KEY(txid),
    FOREIGN KEY(txid) REFERENCES bulletins(txid)
);

CREATE TABLE endorsements (
    txid        TEXT,
    timestamp   INT,  -- Unix time
    author      TEXT, -- formatted as a bitcoin address.

    PRIMARY KEY(txid)
);

CREATE TABLE tags (
    txid TEXT,
    tag  TEXT
);

CREATE INDEX IF NOT EXISTS idx_tags ON tags (tag);
CREATE INDEX IF NOT EXISTS idx_height ON blocks (height);
CREATE INDEX IF NOT EXISTS idx_timestamp ON blocks (timestamp);
