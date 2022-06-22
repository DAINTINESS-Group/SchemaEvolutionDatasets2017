CREATE TABLE binomial_model (	    id integer NOT NULL,
	    model_id integer NOT NULL,
	    mse double precision,
	    r_squared double precision,
	    logloss double precision,
	    auc double precision,
	    gini double precision,
 	    PRIMARY KEY (id),
	    FOREIGN KEY (model_id) REFERENCES model(id) ON DELETE CASCADE	);

CREATE TABLE cluster (	    id integer NOT NULL,
	    name text NOT NULL,
	    type_id integer NOT NULL,
	    detail_id integer NOT NULL,
	    address text NOT NULL,
	    state job_state NOT NULL,
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id),
	    FOREIGN KEY (type_id) REFERENCES cluster_type(id)	);

CREATE TABLE cluster_type (	    id integer NOT NULL,
	    name text NOT NULL UNIQUE,
 	    PRIMARY KEY (id)	);

CREATE TABLE cluster_yarn (	    id integer NOT NULL,
	    engine_id integer NOT NULL,
	    size integer NOT NULL,
	    application_id text NOT NULL,
	    memory text NOT NULL,
	    username text NOT NULL,
	    output_dir text NOT NULL,
	    PRIMARY KEY (id),
	    FOREIGN KEY (engine_id) REFERENCES engine(id)	);

CREATE TABLE dataset (	    id integer NOT NULL,
	    datasource_id integer NOT NULL,
	    name text NOT NULL,
	    description text NOT NULL,
	    frame_name text NOT NULL,
	    response_column_name text NOT NULL,
	    properties text NOT NULL,
	    properties_version text NOT NULL,
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id),
	    FOREIGN KEY (datasource_id) REFERENCES datasource(id) ON DELETE CASCADE	);

CREATE TABLE datasource (	    id integer NOT NULL,
	    project_id integer NOT NULL,
	    name text NOT NULL,
	    description text NOT NULL,
	    kind text NOT NULL,
	    configuration text NOT NULL,
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id),
	    FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE	);

CREATE TABLE engine (	    id integer NOT NULL,
	    name text NOT NULL,
	    location text NOT NULL,
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id)	);

CREATE TABLE entity_type (	    id integer NOT NULL,
	    name text NOT NULL UNIQUE,
	    PRIMARY KEY (id)	);

CREATE TABLE history (	    id integer NOT NULL,
	    action text NOT NULL,
	    identity_id integer NOT NULL,
	    entity_type_id integer NOT NULL,
	    entity_id integer NOT NULL,
	    description text NOT NULL,
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id),
	    FOREIGN KEY (entity_type_id) REFERENCES entity_type(id),
	    FOREIGN KEY (identity_id) REFERENCES identity(id)	);

CREATE TABLE identity (	    id integer NOT NULL,
	    name text NOT NULL UNIQUE,
	    password text NOT NULL,
	    workgroup_id integer NOT NULL,
	    is_active boolean NOT NULL,
	    last_login timestamp with time zone,
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id)	);

CREATE TABLE identity_role (	    identity_id integer NOT NULL,
	    role_id integer NOT NULL,
	    PRIMARY KEY (identity_id,
 role_id)	);

CREATE TABLE identity_workgroup (	    identity_id integer NOT NULL,
	    workgroup_id integer NOT NULL,
	    PRIMARY KEY (identity_id,
 workgroup_id),
	    FOREIGN KEY (identity_id) REFERENCES identity(id) ON DELETE CASCADE,
	    FOREIGN KEY (workgroup_id) REFERENCES workgroup(id) ON DELETE CASCADE	);

CREATE TABLE label (	    id integer NOT NULL,
	    project_id integer NOT NULL,
	    model_id integer,
	    name text NOT NULL,
	    description text NOT NULL,
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id),
	    FOREIGN KEY (model_id) REFERENCES model(id),
	    FOREIGN KEY (project_id) REFERENCES project(id)	);

CREATE TABLE meta (	    id integer NOT NULL,
	    key text NOT NULL UNIQUE,
	    value text NOT NULL,
	    PRIMARY KEY (id)	);

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
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id),
	    FOREIGN KEY (project_id) REFERENCES project(id),
	    FOREIGN KEY (training_dataset_id) REFERENCES dataset(id),
	    FOREIGN KEY (validation_dataset_id) REFERENCES dataset(id)	);

CREATE TABLE multinomial_model (	    id integer NOT NULL,
	    model_id integer NOT NULL,
	    mse double precision,
	    r_squared double precision,
	    logloss double precision,
	    PRIMARY KEY (id),
	    FOREIGN KEY (model_id) REFERENCES model(id) ON DELETE CASCADE	);

CREATE TABLE permission (	    id integer NOT NULL,
	    code text NOT NULL UNIQUE,
	    description text NOT NULL,
	    PRIMARY KEY (id)	);

CREATE TABLE privilege (	    privilege_type text NOT NULL,
	    workgroup_id integer NOT NULL,
	    entity_type_id integer NOT NULL,
	    entity_id integer NOT NULL,
	    PRIMARY KEY (privilege_type,
 workgroup_id,
 entity_type_id,
 entity_id),
	    FOREIGN KEY (entity_type_id) REFERENCES entity_type(id),
	    FOREIGN KEY (workgroup_id) REFERENCES workgroup(id)	);

CREATE TABLE project (	    id integer NOT NULL,
	    name text NOT NULL,
	    description text NOT NULL,
	    model_category text NOT NULL,
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id)	);

CREATE TABLE regression_model (	    id integer NOT NULL,
	    model_id integer NOT NULL,
	    mse double precision,
	    r_squared double precision,
	    mean_residual_deviance double precision,
	    PRIMARY KEY (id),
	    FOREIGN KEY (model_id) REFERENCES model(id) ON DELETE CASCADE	);

CREATE TABLE role (	    id integer NOT NULL,
	    name text NOT NULL UNIQUE,
	    description text NOT NULL,
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id)	);

CREATE TABLE role_permission (	    role_id integer NOT NULL,
	    permission_id integer NOT NULL,
	    PRIMARY KEY (role_id,
 permission_id),
	    FOREIGN KEY (permission_id) REFERENCES permission(id) ON DELETE CASCADE,
	    FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE	);

CREATE TABLE service (	    id integer NOT NULL,
	    project_id integer NOT NULL,
	    model_id integer NOT NULL,
	    name text NOT NULL,
	    address text NOT NULL,
	    port integer NOT NULL,
	    process_id integer NOT NULL,
	    state job_state NOT NULL,
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id),
	    FOREIGN KEY (model_id) REFERENCES model(id)	);

CREATE TABLE workgroup (	    id integer NOT NULL,
	    type workgroup_type NOT NULL,
	    name text NOT NULL UNIQUE,
	    description text NOT NULL,
	    created timestamp with time zone NOT NULL,
	    PRIMARY KEY (id)	);

