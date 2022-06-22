--
-- PostgreSQL database dump
--


--
-- Name: commit_diff_deltas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE commit_diff_deltas (
    id bigint NOT NULL,
    commit_id bigint NOT NULL,
    file_status character varying NOT NULL,
    is_file_binary boolean,
    similarity integer,
    old_file_path character varying NOT NULL,
    new_file_path character varying NOT NULL
);



--
-- Name: commits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE commits (
    id bigint NOT NULL,
    repository_id bigint NOT NULL,
    author_id bigint,
    committer_id bigint,
    hash character varying NOT NULL,
    vcs_id character varying,
    message text,
    author_date timestamp with time zone,
    commit_date timestamp with time zone,
    file_changed_count integer,
    insertions_count integer,
    deletions_count integer
);



--
-- Name: commit_diff_deltas_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY commit_diff_deltas
    ADD CONSTRAINT commit_diff_deltas_pk PRIMARY KEY (id);


--
-- Name: commits_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY commits
    ADD CONSTRAINT commits_pk PRIMARY KEY (id);


--
