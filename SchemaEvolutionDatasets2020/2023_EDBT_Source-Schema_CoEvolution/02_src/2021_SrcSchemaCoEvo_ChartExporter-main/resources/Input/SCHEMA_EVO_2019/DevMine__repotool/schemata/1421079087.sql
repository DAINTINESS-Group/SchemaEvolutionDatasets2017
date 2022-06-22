--
-- PostgreSQL database dump
--


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
-- Name: commits_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY commits
    ADD CONSTRAINT commits_pk PRIMARY KEY (id);

