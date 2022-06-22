-- this must be the same as SCHEMA_USER_VERSION in gtfs.py
-- pragma user_version = 2015020201;

-- TABLES ---------------------------------------------------------------------

create table _feeds (
    url text,
    sha256sum text,
    primary key (url)
);

create table agency (
    _feed_url text not null,
    agency_id text,
    agency_name text not null,
    agency_url text not null,
    agency_timezone text not null,
    agency_lang text,
    agency_phone text,
    agency_fare_url text,
    primary key (_feed_url, agency_id),
    foreign key (_feed_url) references _feeds (url)
);

create table stops (
    _feed_url text not null,
    stop_id text not null,
    stop_code text,
    stop_name text not null,
    stop_desc text,
    stop_lat real not null,
    stop_lon real not null,
    zone_id text,
    stop_url text,
    location_type integer,
    parent_station text,
    stop_timezone text,
    wheelchair_boarding text,
    primary key (_feed_url, stop_id),
    foreign key (_feed_url) references _feeds (url),
    foreign key (_feed_url, parent_station) references stops (_feed_url, stop_id)
);

create table routes (
    _feed_url text not null,
    route_id text not null,
    agency_id text,
    -- If the route does not have a short name, please specify a
    -- route_long_name and use an empty string as the value for this field.
    route_short_name text,
    route_long_name text not null,
    route_desc text,
    route_type integer not null,
    route_url text,
    route_color text,
    route_text_color text,
    primary key (_feed_url, route_id),
    foreign key (_feed_url, agency_id) references agencies (_feed_url, agency_id)
);

create table trips (
    _feed_url text not null,
    route_id text not null,
    service_id text not null,
    trip_id text not null,
    trip_headsign text,
    trip_short_name text,
    direction_id integer,
    block_id text,
    shape_id text,
    wheelchair_accessible integer,
    bikes_allowed integer,
    primary key (_feed_url, trip_id),
    foreign key (_feed_url, route_id) references routes (_feed_url, route_id),
    foreign key (_feed_url, service_id) references calendar (_feed_url, service_id)
);

create table stop_times (
    _feed_url text not null,
    trip_id text not null,
    -- GTFS says arrival_time/departure_time are required but they're actually
    -- not; if missing they are to be interpolated
    arrival_time gtfstime,
    departure_time gtfstime,
    stop_id text not null,
    stop_sequence integer not null,
    stop_headsign text,
    pickup_type integer,
    drop_off_type integer,
    shape_dist_traveled real,
    timepoint integer,
    primary key (_feed_url, trip_id, stop_sequence),
    foreign key (_feed_url, trip_id) references trips (_feed_url, trip_id),
    foreign key (_feed_url, stop_id) references stops (_feed_url, stop_id)
);

create table calendar (
    _feed_url text not null,
    service_id text not null,
    monday integer not null,
    tuesday integer not null,
    wednesday integer not null,
    thursday integer not null,
    friday integer not null,
    saturday integer not null,
    sunday integer not null,
    start_date date not null,
    end_date date not null,
    primary key (_feed_url, service_id)
);

create table calendar_dates (
    _feed_url text not null,
    service_id text not null,
    date date not null,
    exception_type integer not null,
    foreign key (_feed_url, service_id) references calendar (_feed_url, service_id)
);

/*
create table fare_attributes (
    _feed_url text not null,
    fare_id text not null,
    price text not null, -- text is deliberate; floating point currency is a nightmare
    currency_type text not null,
    payment_method integer not null,
    transfers integer not null,
    transfer_duration timedelta,
    primary key (_feed_url, fare_id)
);

create table fare_rules (
    _feed_url text not null,
    fare_id text not null,
    route_id text,
    origin_id text,
    destination_id text,
    contains_id text,
    foreign key (_feed_url, fare_id) references fare_attributes (_feed_url, fare_id)
);

create table shapes (
    _feed_url text not null,
    shape_id text not null,
    shape_pt_lat real not null,
    shape_pt_lon real not null,
    shape_pt_sequence integer not null,
    shape_dist_traveled real,
    primary key (_feed_url, shape_id, shape_pt_sequence)
);
*/

create table frequencies (
    _feed_url text not null,
    trip_id text not null,
    start_time gtfstime not null,
    end_time gtfstime not null,
    headway_secs timedelta not null,
    exact_times integer
);

/*
create table transfers (
    _feed_url text not null,
    from_stop_id text not null,
    to_stop_id text not null,
    transfer_type integer not null,
    min_transfer_time timedelta,
    foreign key (_feed_url, from_stop_id) references stops (_feed_url, stop_id),
    foreign key (_feed_url, to_stop_id) references stops (_feed_url, stop_id)
);

create table feed_info (
    _feed_url text not null,
    feed_publisher_name text not null,
    feed_publisher_url text not null,
    feed_lang text not null,
    feed_start_date date,
    feed_end_date date,
    feed_version text
);
*/

-- VIEWS ----------------------------------------------------------------------

create view trips_v as
    select t.*, st.min_arrival_time from trips as t join
        (select _feed_url, trip_id, min(arrival_time) as min_arrival_time from stop_times group by trip_id) as st
        on t.trip_id=st.trip_id and t._feed_url=st._feed_url;
