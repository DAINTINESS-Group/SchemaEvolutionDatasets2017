CREATE TABLE access_tokens (	    access_token_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    author_id uuid NOT NULL,
	    expires_at timestamp without time zone NOT NULL,
	    created_at timestamp without time zone,
	    updated_at timestamp without time zone	);

CREATE TABLE assets (	    asset_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    author_id uuid NOT NULL,
	    name text NOT NULL,
	    description text,
	    data text NOT NULL,
	    md5sum text NOT NULL,
	    mime_type text NOT NULL,
	    file_size integer,
	    created_at timestamp without time zone,
	    updated_at timestamp without time zone,
	    deleted_at timestamp without time zone	);

CREATE TABLE audits (	    id integer NOT NULL,
	    auditable_id uuid,
	    auditable_type character varying(255),
	    notes text,
	    approver text,
	    flags character varying(255)[] DEFAULT '{}'::character varying[],
	    created_at timestamp without time zone,
	    updated_at timestamp without time zone	);

CREATE TABLE authors (	    author_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    email text NOT NULL,
	    username text NOT NULL,
	    first_name text NOT NULL,
	    last_name text NOT NULL,
	    created_at timestamp without time zone,
	    updated_at timestamp without time zone	);

CREATE TABLE categories (	    category_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    name text,
	    description text,
	    slug text NOT NULL	);

CREATE TABLE page_assets (	    page_asset_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    page_id uuid NOT NULL,
	    asset_id uuid NOT NULL	);

CREATE TABLE page_revision_assets (	    page_revision_asset_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    page_revision_id uuid NOT NULL,
	    asset_id uuid NOT NULL	);

CREATE TABLE page_revisions (	    page_revision_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    ordinal integer,
	    notes text,
	    is_minor boolean DEFAULT false,
	    is_published boolean DEFAULT true,
	    page_id uuid NOT NULL,
	    author_id uuid NOT NULL,
	    created_at timestamp without time zone,
	    updated_at timestamp without time zone,
	    theme_id uuid,
	    category_id uuid,
	    redirect_url text,
	    body text,
	    title text,
	    path text,
	    meta_tags public.hstore,
	    head_content text,
	    status_code smallint,
	    abstract text,
	    hero_asset_id uuid,
	    screenshot text	);

CREATE TABLE page_templates (	    page_template_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    page_id uuid NOT NULL,
	    template_id uuid NOT NULL	);

CREATE TABLE pages (	    page_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    published_revision_id uuid,
	    is_publishable boolean DEFAULT true NOT NULL,
	    theme_id uuid,
	    category_id uuid,
	    path text NOT NULL,
	    title text,
	    body text,
	    redirect_url text,
	    meta_tags public.hstore,
	    imported_at timestamp without time zone,
	    created_at timestamp without time zone,
	    updated_at timestamp without time zone,
	    updated_by_author_id uuid,
	    lock_version integer DEFAULT 0 NOT NULL,
	    head_content text,
	    status_code smallint DEFAULT 200 NOT NULL,
	    abstract text,
	    hero_asset_id uuid,
	    deleted_at timestamp without time zone,
	    audit_flags character varying(255)[] DEFAULT '{}'::character varying[],
	    CONSTRAINT only_valid_paths CHECK ((path ~ '^/[a-zA-Z0-9/_.~-]*$'::text))	);

CREATE TABLE template_revisions (	    template_revision_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    ordinal integer,
	    notes text,
	    is_minor boolean DEFAULT false,
	    is_published boolean DEFAULT true,
	    template_id uuid NOT NULL,
	    author_id uuid NOT NULL,
	    name text,
	    slug text,
	    body text,
	    description text,
	    created_at timestamp without time zone,
	    updated_at timestamp without time zone	);

CREATE TABLE templates (	    template_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    name text NOT NULL,
	    slug text NOT NULL,
	    body text NOT NULL,
	    description text NOT NULL,
	    thumbnail_url text,
	    is_layout boolean DEFAULT false NOT NULL,
	    created_at timestamp without time zone,
	    updated_at timestamp without time zone,
	    file text,
	    editable boolean DEFAULT true,
	    deleted_at timestamp without time zone,
	    published_revision_id uuid,
	    is_publishable boolean DEFAULT true,
	    audit_flags character varying(255)[] DEFAULT '{}'::character varying[]	);

CREATE TABLE theme_assets (	    theme_asset_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    theme_id uuid NOT NULL,
	    asset_id uuid NOT NULL	);

CREATE TABLE themes (	    theme_id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	    name text NOT NULL,
	    body text NOT NULL,
	    description text NOT NULL,
	    thumbnail_url text,
	    created_at timestamp without time zone,
	    updated_at timestamp without time zone,
	    file text,
	    extension text,
	    editable boolean DEFAULT true NOT NULL,
	    deleted_at timestamp without time zone	);

CREATE TABLE accesses (	    access_id integer NOT NULL,
	    path_id integer NOT NULL,
	    visitor_id integer NOT NULL,
	    last_accessed_at timestamp with time zone DEFAULT now() NOT NULL	);

CREATE TABLE ad_groups (	    ad_group_id integer NOT NULL,
	    ad_group text NOT NULL	);

CREATE TABLE ad_types (	    ad_type_id smallint NOT NULL,
	    ad_type text NOT NULL	);

CREATE TABLE attributions (	    attribution_id integer NOT NULL,
	    ad_type_id smallint,
	    ad_group_id integer,
	    bid_match_type_id smallint,
	    campaign_id integer,
	    content_id integer,
	    creative_id integer,
	    device_type_id smallint,
	    experiment_id integer,
	    keyword_id integer,
	    match_type_id smallint,
	    medium_id integer,
	    network_id integer,
	    placement_id integer,
	    position_id smallint,
	    search_term_id integer,
	    source_id integer,
	    target_id integer,
	    created_at timestamp with time zone DEFAULT now() NOT NULL	);

CREATE TABLE bid_match_types (	    bid_match_type_id smallint NOT NULL,
	    bid_match_type text NOT NULL	);

CREATE TABLE browsers (	    browser_id smallint NOT NULL,
	    browser text NOT NULL	);

CREATE TABLE campaigns (	    campaign_id integer NOT NULL,
	    campaign text NOT NULL	);

CREATE TABLE cities (	    city_id integer NOT NULL,
	    city text NOT NULL	);

CREATE TABLE contents (	    content_id integer NOT NULL,
	    content text NOT NULL	);

CREATE TABLE cookies (	    cookie_id uuid DEFAULT public.uuid_generate_v4() NOT NULL	);

CREATE TABLE countries (	    country_id integer NOT NULL,
	    country text NOT NULL	);

CREATE TABLE creatives (	    creative_id integer NOT NULL,
	    creative text NOT NULL	);

CREATE TABLE device_types (	    device_type_id smallint NOT NULL,
	    device_type text NOT NULL	);

CREATE TABLE devices (	    device_id integer NOT NULL,
	    device text NOT NULL	);

CREATE TABLE domains (	    domain_id integer NOT NULL,
	    domain text NOT NULL	);

CREATE TABLE event_types (	    event_type_id integer NOT NULL,
	    event_type text NOT NULL	);

CREATE TABLE events (	    event_id integer NOT NULL,
	    event_type_id integer NOT NULL,
	    visit_id integer NOT NULL,
	    created_at timestamp with time zone DEFAULT now() NOT NULL,
	    meta public.hstore	);

CREATE TABLE experiments (	    experiment_id integer NOT NULL,
	    experiment text NOT NULL	);

CREATE TABLE http_methods (	    http_method_id smallint NOT NULL,
	    http_method text NOT NULL	);

CREATE TABLE ip_addresses (	    ip_address_id integer NOT NULL,
	    ip_address inet NOT NULL	);

CREATE TABLE ip_lookups (	    ip_lookup_id integer NOT NULL,
	    ip_address_id integer NOT NULL,
	    domain_id integer,
	    location_id integer,
	    latitude real,
	    longitude real,
	    created_at timestamp with time zone DEFAULT now() NOT NULL	);

CREATE TABLE keywords (	    keyword_id integer NOT NULL,
	    keyword text NOT NULL	);

CREATE TABLE locations (	    location_id integer NOT NULL,
	    country_id integer,
	    region_id integer,
	    city_id integer	);

CREATE TABLE match_types (	    match_type_id smallint NOT NULL,
	    match_type text NOT NULL	);

CREATE TABLE mediums (	    medium_id integer NOT NULL,
	    medium text NOT NULL	);

CREATE TABLE mime_types (	    mime_type_id smallint NOT NULL,
	    mime_type text NOT NULL	);

CREATE TABLE networks (	    network_id integer NOT NULL,
	    network text NOT NULL	);

CREATE TABLE owners (	    owner_id integer NOT NULL,
	    owner integer NOT NULL	);

CREATE TABLE ownerships (	    owner_id integer NOT NULL,
	    cookie_id uuid NOT NULL	);

CREATE TABLE page_views (	    page_view_id integer NOT NULL,
	    visit_id integer NOT NULL,
	    path_id integer NOT NULL,
	    query_string_id integer NOT NULL,
	    mime_type_id smallint NOT NULL,
	    http_method_id smallint NOT NULL,
	    page_revision_id uuid,
	    request_id uuid,
	    click_id text,
	    content_length integer,
	    http_status integer,
	    created_at timestamp with time zone DEFAULT now() NOT NULL,
	    response_time integer	);

CREATE TABLE paths (	    path_id integer NOT NULL,
	    path text NOT NULL	);

CREATE TABLE placements (	    placement_id integer NOT NULL,
	    placement text NOT NULL	);

CREATE TABLE platforms (	    platform_id smallint NOT NULL,
	    platform text NOT NULL	);

CREATE TABLE positions (	    position_id smallint NOT NULL,
	    "position" text NOT NULL	);

CREATE TABLE query_strings (	    query_string_id integer NOT NULL,
	    query_string text NOT NULL	);

CREATE TABLE referers (	    referer_id integer NOT NULL,
	    domain_id integer NOT NULL,
	    path_id integer NOT NULL,
	    query_string_id integer NOT NULL,
	    attribution_id integer NOT NULL	);

CREATE TABLE regions (	    region_id integer NOT NULL,
	    region text NOT NULL	);

CREATE TABLE search_terms (	    search_term_id integer NOT NULL,
	    search_term text NOT NULL	);

CREATE TABLE sources (	    source_id integer NOT NULL,
	    source text NOT NULL	);

CREATE TABLE targets (	    target_id integer NOT NULL,
	    target text NOT NULL	);

CREATE TABLE user_agent_types (	    user_agent_type_id smallint NOT NULL,
	    user_agent_type text NOT NULL	);

CREATE TABLE user_agents (	    user_agent_id integer NOT NULL,
	    user_agent_type_id smallint,
	    device_id integer,
	    platform_id smallint,
	    browser_id smallint,
	    browser_version text,
	    user_agent text NOT NULL,
	    created_at timestamp with time zone DEFAULT now() NOT NULL	);

CREATE TABLE visitors (	    visitor_id integer NOT NULL,
	    ip_address_id integer NOT NULL,
	    user_agent_id integer NOT NULL	);

CREATE TABLE visits (	    visit_id integer NOT NULL,
	    cookie_id uuid NOT NULL,
	    visitor_id integer NOT NULL,
	    attribution_id integer NOT NULL,
	    referer_id integer,
	    owner_id integer,
	    created_at timestamp with time zone DEFAULT now() NOT NULL,
	    do_not_track boolean	);

CREATE TABLE schema_migrations (	    version character varying(255) NOT NULL	);

