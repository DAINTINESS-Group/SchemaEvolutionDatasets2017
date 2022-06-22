CREATE TABLE binomial_model (	    id integer NOT NULL,
	    model_id integer NOT NULL,
	    mse double precision,
	    r_squared double precision,
	    logloss double precision,
	    auc double precision,
	    gini double precision	);

CREATE TABLE cluster (	    id integer NOT NULL,
	    name text NOT NULL,
	    type_id integer NOT NULL,
	    detail_id integer NOT NULL,
	    address text NOT NULL,
	    state job_state NOT NULL,
	    created timestamp with time zone NOT NULL	);

CREATE TABLE cluster_type (	    id integer NOT NULL,
	    name text NOT NULL	);

CREATE TABLE cluster_yarn (	    id integer NOT NULL,
	    engine_id integer NOT NULL,
	    size integer NOT NULL,
	    application_id text NOT NULL,
	    memory text NOT NULL,
	    username text NOT NULL,
	    output_dir text NOT NULL	);

CREATE TABLE dataset (	    id integer NOT NULL,
	    datasource_id integer NOT NULL,
	    name text NOT NULL,
	    description text NOT NULL,
	    frame_name text NOT NULL,
	    response_column_name text NOT NULL,
	    properties text NOT NULL,
	    properties_version text NOT NULL,
	    created timestamp with time zone NOT NULL	);

CREATE TABLE datasource (	    id integer NOT NULL,
	    project_id integer NOT NULL,
	    name text NOT NULL,
	    description text NOT NULL,
	    kind text NOT NULL,
	    configuration text NOT NULL,
	    created timestamp with time zone NOT NULL	);

CREATE TABLE engine (	    id integer NOT NULL,
	    name text NOT NULL,
	    location text NOT NULL,
	    created timestamp with time zone NOT NULL	);

CREATE TABLE entity_type (	    id integer NOT NULL,
	    name text NOT NULL	);

CREATE TABLE history (	    id integer NOT NULL,
	    action text NOT NULL,
	    identity_id integer NOT NULL,
	    entity_type_id integer NOT NULL,
	    entity_id integer NOT NULL,
	    description text NOT NULL,
	    created timestamp with time zone NOT NULL	);

CREATE TABLE identity (	    id integer NOT NULL,
	    name text NOT NULL,
	    password text NOT NULL,
	    workgroup_id integer NOT NULL,
	    is_active boolean NOT NULL,
	    last_login timestamp with time zone,
	    created timestamp with time zone NOT NULL	);

CREATE TABLE identity_role (	    identity_id integer NOT NULL,
	    role_id integer NOT NULL	);

CREATE TABLE identity_workgroup (	    identity_id integer NOT NULL,
	    workgroup_id integer NOT NULL	);

CREATE TABLE label (	    id integer NOT NULL,
	    project_id integer NOT NULL,
	    model_id integer,
	    name text NOT NULL,
	    description text NOT NULL,
	    created timestamp with time zone NOT NULL	);

CREATE TABLE meta (	    id integer NOT NULL,
	    key text NOT NULL,
	    value text NOT NULL	);

CREATE TABLE model (	    id integer NOT NULL,
	    project_id integer NOT NULL,
	    training_dataset_id integer NOT NULL,
	    validation_dataset_id integer NOT NULL,
	    name text NOT NULL,
	    cluster_name text NOT NULL,
	    model_key text NOT NULL,
	    algorithm text NOT NULL,
	    model_category text NOT NULL,
	    dataset_name text NOT NULL,
	    response_column_name text NOT NULL,
	    logical_name text NOT NULL,
	    location text NOT NULL,
	    max_run_time integer,
	    metrics text NOT NULL,
	    metrics_version text NOT NULL,
	    created timestamp with time zone NOT NULL	);

CREATE TABLE multinomial_model (	    id integer NOT NULL,
	    model_id integer NOT NULL,
	    mse double precision,
	    r_squared double precision,
	    logloss double precision	);

CREATE TABLE permission (	    id integer NOT NULL,
	    code text NOT NULL,
	    description text NOT NULL	);

CREATE TABLE privilege (	    privilege_type privilege_type NOT NULL,
	    workgroup_id integer NOT NULL,
	    entity_type_id integer NOT NULL,
	    entity_id integer NOT NULL	);

CREATE TABLE project (	    id integer NOT NULL,
	    name text NOT NULL,
	    description text NOT NULL,
	    model_category text NOT NULL,
	    created timestamp with time zone NOT NULL	);

CREATE TABLE regression_model (	    id integer NOT NULL,
	    model_id integer NOT NULL,
	    mse double precision,
	    r_squared double precision,
	    mean_residual_deviance double precision	);

CREATE TABLE role (	    id integer NOT NULL,
	    name text NOT NULL,
	    description text NOT NULL,
	    created timestamp with time zone NOT NULL	);

CREATE TABLE role_permission (	    role_id integer NOT NULL,
	    permission_id integer NOT NULL	);

CREATE TABLE service (	    id integer NOT NULL,
	    project_id integer NOT NULL,
	    model_id integer NOT NULL,
	    address text NOT NULL,
	    port integer NOT NULL,
	    process_id integer NOT NULL,
	    state job_state NOT NULL,
	    created timestamp with time zone NOT NULL	);

CREATE TABLE workgroup (	    id integer NOT NULL,
	    type workgroup_type NOT NULL,
	    name text NOT NULL,
	    description text NOT NULL,
	    created timestamp with time zone NOT NULL	);

