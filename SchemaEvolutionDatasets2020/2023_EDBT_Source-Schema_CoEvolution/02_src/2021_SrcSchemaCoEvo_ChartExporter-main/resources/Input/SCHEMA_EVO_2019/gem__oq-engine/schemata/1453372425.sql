/*
  Copyright (c) 2010-2014, GEM Foundation.

  OpenQuake is free software: you can redistribute it and/or modify it
  under the terms of the GNU Affero General Public License as published
  by the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  OpenQuake is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU Affero General Public License
  along with OpenQuake.  If not, see <http://www.gnu.org/licenses/>.
*/


-- Disable unnecessarily verbose output
SET client_min_messages TO WARNING;

-- Set role to oq_admin
SET ROLE TO oq_admin;

------------------------------------------------------------------------
-- Name space definitions go here
------------------------------------------------------------------------
CREATE SCHEMA hzrdi;
CREATE SCHEMA hzrdr;
CREATE SCHEMA riski;
CREATE SCHEMA riskr;
CREATE SCHEMA uiapi;
COMMENT ON SCHEMA hzrdi IS 'Hazard input model';
COMMENT ON SCHEMA hzrdr IS 'Hazard result data';
COMMENT ON SCHEMA riski IS 'Risk input model';
COMMENT ON SCHEMA riskr IS 'Risk result data';
COMMENT ON SCHEMA uiapi IS 'Data required by the API presented to the various OpenQuake UIs';

------------------------------------------------------------------------
-- Table definitions go here
------------------------------------------------------------------------


-- Site-specific parameters for hazard calculations.
CREATE TABLE site_model (
    id SERIAL PRIMARY KEY,
    job_id INTEGER NOT NULL,
    -- Average shear wave velocity for top 30 m. Units m/s.
    vs30 float NOT NULL CONSTRAINT site_model_vs30
        CHECK(vs30 > 0.0),
    -- 'measured' or 'inferred'. Identifies if vs30 value has been measured or inferred.
    vs30_type VARCHAR NOT NULL CONSTRAINT site_model_vs30_type
        CHECK(vs30_type in ('measured', 'inferred')),
    -- Depth to shear wave velocity of 1.0 km/s. Units m.
    z1pt0 float NOT NULL CONSTRAINT site_model_z1pt0
        CHECK(z1pt0 > 0.0),
    -- Depth to shear wave velocity of 2.5 km/s. Units km.
    z2pt5 float NOT NULL CONSTRAINT site_model_z2pt5
        CHECK(z2pt5 > 0.0)
) TABLESPACE hzrdi_ts;
SELECT AddGeometryColumn('hzrdi', 'site_model', 'location', 4326, 'POINT', 2);

-- table for the intensity measure types
CREATE TABLE imt(
  id SERIAL PRIMARY KEY,
  imt_str VARCHAR UNIQUE NOT NULL, -- full string representation of the IMT
  im_type VARCHAR NOT NULL, -- short string for the IMT
  sa_period FLOAT CONSTRAINT imt_sa_period
        CHECK(((im_type = 'SA') AND (sa_period IS NOT NULL))
              OR ((im_type != 'SA') AND (sa_period IS NULL))),
  sa_damping FLOAT CONSTRAINT imt_sa_damping
        CHECK(((im_type = 'SA') AND (sa_damping IS NOT NULL))
            OR ((im_type != 'SA') AND (sa_damping IS NULL))),
  UNIQUE (im_type, sa_period, sa_damping)
) TABLESPACE hzrdi_ts;

-- An OpenQuake engine run started by the user
CREATE TABLE oq_job (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR NOT NULL,
    hazard_calculation_id INTEGER,  -- FK to hazard_calculation
    risk_calculation_id INTEGER,  -- FK to risk_calculation
    log_level VARCHAR NOT NULL DEFAULT 'progress' CONSTRAINT oq_job_log_level_check
        CHECK(log_level IN ('debug', 'info', 'progress', 'warn', 'error', 'critical')),
    -- One of: pre_execution, executing, post_execution, post_processing, complete
    status VARCHAR NOT NULL DEFAULT 'pre_executing' CONSTRAINT job_status_value
        CHECK(status IN ('pre_executing', 'executing', 'post_executing',
                         'post_processing', 'export', 'clean_up', 'complete')),
    oq_version VARCHAR,
    hazardlib_version VARCHAR,
    nrml_version VARCHAR,
    risklib_version VARCHAR,
    is_running BOOLEAN NOT NULL DEFAULT FALSE,
    duration INTEGER NOT NULL DEFAULT 0,
    job_pid INTEGER NOT NULL DEFAULT 0,
    supervisor_pid INTEGER NOT NULL DEFAULT 0,
    last_update timestamp without time zone
        DEFAULT timezone('UTC'::text, now()) NOT NULL
) TABLESPACE uiapi_ts;

COMMENT ON TABLE oq_job IS 'Date related to an OpenQuake job that was created in the UI.';
COMMENT ON COLUMN oq_job.job_pid IS 'The process id (PID) of the OpenQuake engine runner process';
COMMENT ON COLUMN oq_job.supervisor_pid IS 'The process id (PID) of the supervisor for this OpenQuake job';
COMMENT ON COLUMN oq_job.status IS 'One of: pending, running, failed or succeeded.';
COMMENT ON COLUMN oq_job.duration IS 'The job''s duration in seconds (only available once the jobs terminates).';

-- Tracks task performance
CREATE TABLE performance (
    id SERIAL PRIMARY KEY,
    oq_job_id INTEGER NOT NULL,
    task_id VARCHAR,
    start_time timestamp without time zone NOT NULL,
    task VARCHAR,
    operation VARCHAR NOT NULL,
    duration FLOAT,
    pymemory BIGINT,
    pgmemory BIGINT
)  TABLESPACE uiapi_ts;

COMMENT ON TABLE performance IS 'Tracks task performance';
COMMENT ON COLUMN performance.duration IS 'Duration of the operation in seconds';
COMMENT ON COLUMN performance.pymemory IS 'Memory occupation in Python (Mbytes)';
COMMENT ON COLUMN performance.pgmemory IS 'Memory occupation in Postgres (Mbytes)';


-- Tracks various job statistics
CREATE TABLE job_stats (
    id SERIAL PRIMARY KEY,
    oq_job_id INTEGER NOT NULL,
    start_time timestamp without time zone
        DEFAULT timezone('UTC'::text, now()) NOT NULL,
    stop_time timestamp without time zone,
    -- The number of total sites in the calculation
    disk_space BIGINT -- The disk space occupation in bytes
) TABLESPACE uiapi_ts;

COMMENT ON TABLE job_stats IS 'Tracks various job statistics';
COMMENT ON COLUMN job_stats.disk_space IS 'How much the disk space occupation increased during the computation (in bytes)';


CREATE TABLE hazard_calculation (
    id SERIAL PRIMARY KEY,
    -- Contains the absolute path to the directory containing the job config
    -- file
    base_path VARCHAR NOT NULL,
    export_dir VARCHAR,
    -- general parameters:
    -- (see also `region` and `sites` geometries defined below)
    description VARCHAR NOT NULL DEFAULT '',
    calculation_mode VARCHAR NOT NULL CONSTRAINT haz_calc_mode
        CHECK(calculation_mode IN (
            'classical',
            'event_based',
            'disaggregation',
            'scenario'
        )),
    inputs BYTEA,  -- stored as a pickled Python `dict`
    region_grid_spacing float,
    -- logic tree parameters:
    random_seed INTEGER NOT NULL,
    number_of_logic_tree_samples INTEGER,
    -- ERF parameters:
    rupture_mesh_spacing float,
    width_of_mfd_bin float,
    area_source_discretization float,
    -- site parameters:
    reference_vs30_value float,
    reference_vs30_type VARCHAR CONSTRAINT vs30_type
        CHECK(((reference_vs30_type IS NULL)
               OR
               (reference_vs30_type IN ('measured', 'inferred')))),
    reference_depth_to_2pt5km_per_sec float,
    reference_depth_to_1pt0km_per_sec float,
    -- calculation parameters:
    investigation_time float,
    intensity_measure_types_and_levels bytea NOT NULL,  -- stored as a pickled Python `dict`
    truncation_level float,
    maximum_distance float NOT NULL,
    -- event-based calculator parameters:
    intensity_measure_types VARCHAR[],
    ses_per_logic_tree_path INTEGER,
    ground_motion_correlation_model VARCHAR,
    ground_motion_correlation_params bytea, -- stored as a pickled Python `dict`
    -- scenario calculator parameters:
    gsim VARCHAR,
    number_of_ground_motion_fields INTEGER,
    -- disaggregation calculator parameters:
    mag_bin_width float,
    distance_bin_width float,
    coordinate_bin_width float,
    num_epsilon_bins INTEGER,
    poes_disagg float[],
    -- output/post-processing parameters:
    -- classical:
    mean_hazard_curves boolean DEFAULT false,
    quantile_hazard_curves float[],
    poes float[],
    hazard_maps boolean DEFAULT false,
    uniform_hazard_spectra boolean DEFAULT false,
    export_multi_curves boolean DEFAULT false,
    -- event-based:
    ground_motion_fields BOOLEAN,
    hazard_curves_from_gmfs BOOLEAN
) TABLESPACE uiapi_ts;
SELECT AddGeometryColumn('uiapi', 'hazard_calculation', 'region', 4326, 'POLYGON', 2);
SELECT AddGeometryColumn('uiapi', 'hazard_calculation', 'sites', 4326, 'MULTIPOINT', 2);


CREATE TABLE risk_calculation (
    id SERIAL PRIMARY KEY,
    -- Contains the absolute path to the directory containing the job config
    -- file
    base_path VARCHAR NOT NULL,
    export_dir VARCHAR,
    -- general parameters:
    description VARCHAR NOT NULL DEFAULT '',
    calculation_mode VARCHAR NOT NULL,
    inputs BYTEA,  -- stored as a pickled Python `dict`

    maximum_distance FLOAT NULL,

    preloaded_exposure_model_id INTEGER,

    hazard_output_id INTEGER NULL,  -- FK to output
    hazard_calculation_id INTEGER NULL,  -- FK to hazard_calculation

    risk_investigation_time float NULL,

    quantile_loss_curves float[],
    conditional_loss_poes float[],

    poes_disagg float[],

    taxonomies_from_model BOOLEAN,

    -- probabilistic parameters
    asset_correlation float NULL
    CONSTRAINT asset_correlation_value
    CHECK (
      (asset_correlation IS NULL) OR
      ((asset_correlation >= 0) AND (asset_correlation <= 1))),
    master_seed INTEGER NOT NULL,

    mag_bin_width float,
    distance_bin_width float,
    coordinate_bin_width float,

    -- classical parameters:
    lrem_steps_per_interval INTEGER,

    -- event-based parameters:
    loss_curve_resolution INTEGER NOT NULL DEFAULT 50
        CONSTRAINT loss_curve_resolution_is_set
        CHECK  (loss_curve_resolution >= 1),
    insured_losses BOOLEAN DEFAULT false,

    -- BCR (Benefit-Cost Ratio) parameters:
    interest_rate float,
    asset_life_expectancy float,

    -- Scenario parameters:
    time_event VARCHAR
) TABLESPACE uiapi_ts;
SELECT AddGeometryColumn('uiapi', 'risk_calculation', 'region_constraint', 4326, 'POLYGON', 2);
SELECT AddGeometryColumn('uiapi', 'risk_calculation', 'sites_disagg', 4326, 'MULTIPOINT', 2);

-- A single OpenQuake calculation engine output. The data may reside in a file
-- or in the database.
CREATE TABLE output (
    id SERIAL PRIMARY KEY,
    oq_job_id INTEGER NOT NULL,
    -- The full path of the output file on the server, optional and only set
    -- for outputs with NRML/XML files.
    display_name VARCHAR NOT NULL,
    output_type VARCHAR NOT NULL CONSTRAINT output_type_value
        CHECK(output_type IN (
            'agg_loss_curve',
            'aggregate_loss',
            'bcr_distribution',
            'collapse_map',
            'disagg_matrix',
            'dmg_dist_per_asset',
            'dmg_dist_per_taxonomy',
            'dmg_dist_total',
            'event_loss',
            'event_loss_curve',
            'gmf',
            'gmf_scenario',
            'hazard_curve',
            'hazard_curve_multi',
            'hazard_map',
            'loss_curve',
            'loss_fraction',
            'loss_map',
            'ses',
            'uh_spectra',
            'unknown'
        )),
    last_update timestamp without time zone
        DEFAULT timezone('UTC'::text, now()) NOT NULL
) TABLESPACE uiapi_ts;

COMMENT ON TABLE output IS 'A single OpenQuake calculation engine output. The data may reside in a file or in the database.';
COMMENT ON COLUMN output.display_name IS 'The GUI display name to be used for this output.';
COMMENT ON COLUMN output.output_type IS 'Output type, one of:
    - unknown
    - hazard_curve
    - hazard_map
    - gmf
    - loss_curve
    - loss_map
    - dmg_dist_per_asset
    - dmg_dist_per_taxonomy
    - dmg_dist_total
    - bcr_distribution';
COMMENT ON COLUMN output.oq_job_id IS 'The job that produced this output;
NULL if the output was imported from an external source';


-- Complete hazard map
CREATE TABLE hazard_map (
    id SERIAL PRIMARY KEY,
    output_id INTEGER NOT NULL,
    lt_realization_id INTEGER,  -- lt_realization FK, only required for non-statistical curves
    investigation_time float NOT NULL,
    imt VARCHAR NOT NULL CONSTRAINT hazard_map_imt
        CHECK(imt in ('PGA', 'PGV', 'PGD', 'SA', 'IA', 'RSD', 'MMI')),
    statistics VARCHAR CONSTRAINT hazard_map_statistics
        CHECK(statistics IS NULL OR
              statistics IN ('mean', 'quantile')),
    -- Quantile value (only for "quantile" statistics)
    quantile float CONSTRAINT hazard_map_quantile_value
        CHECK(
            ((statistics = 'quantile') AND (quantile IS NOT NULL))
            OR (((statistics != 'quantile') AND (quantile IS NULL)))),
    sa_period float CONSTRAINT hazard_map_sa_period
        CHECK(
            ((imt = 'SA') AND (sa_period IS NOT NULL))
            OR ((imt != 'SA') AND (sa_period IS NULL))),
    sa_damping float CONSTRAINT hazard_map_sa_damping
        CHECK(
            ((imt = 'SA') AND (sa_damping IS NOT NULL))
            OR ((imt != 'SA') AND (sa_damping IS NULL))),
    poe float NOT NULL,
    lons float[] NOT NULL,
    lats float[] NOT NULL,
    imls float[] NOT NULL
) TABLESPACE hzrdr_ts;

COMMENT ON TABLE hazard_map IS 'A complete hazard map, for a given IMT and PoE';
COMMENT ON COLUMN hazard_map.poe IS 'Probability of exceedence';
COMMENT ON COLUMN hazard_map.statistics IS 'Statistic type, one of:
    - Median   (median)
    - Quantile (quantile)';
COMMENT ON COLUMN hazard_map.quantile IS 'The quantile level for quantile statistical data.';


-- Hazard curve data.
CREATE TABLE hazard_curve (
    id SERIAL PRIMARY KEY,
    output_id INTEGER NOT NULL,
    lt_realization_id INTEGER,  -- lt_realization FK, only required for non-statistical curves
    investigation_time float NOT NULL,
    -- imt and imls might be null if hazard curve is the container for multiple hazard curve set
    imt VARCHAR NULL CONSTRAINT hazard_curve_imt
        CHECK(imt in ('PGA', 'PGV', 'PGD', 'SA', 'IA', 'RSD', 'MMI')),
    imls float[] NULL,
    statistics VARCHAR CONSTRAINT hazard_curve_statistics
        CHECK(statistics IS NULL OR
              statistics IN ('mean', 'quantile')),
    -- Quantile value (only for "quantile" statistics)
    quantile float CONSTRAINT quantile_value
        CHECK(
            ((statistics = 'quantile') AND (quantile IS NOT NULL))
            OR (((statistics != 'quantile') AND (quantile IS NULL)))),
    sa_period float CONSTRAINT hazard_curve_sa_period
        CHECK(
            ((imt = 'SA') AND (sa_period IS NOT NULL))
            OR ((imt != 'SA') AND (sa_period IS NULL))),
    sa_damping float CONSTRAINT hazard_curve_sa_damping
        CHECK(
            ((imt = 'SA') AND (sa_damping IS NOT NULL))
            OR ((imt != 'SA') AND (sa_damping IS NULL)))
) TABLESPACE hzrdr_ts;

COMMENT ON TABLE hazard_curve IS 'A collection of hazard curves. This table defines common attributes for the collection.';
COMMENT ON COLUMN hazard_curve.output_id IS 'The foreign key to the output record that represents the corresponding hazard curve.';
COMMENT ON COLUMN hazard_curve.lt_realization_id IS 'Only required for non-statistical curves';
COMMENT ON COLUMN hazard_curve.imt IS 'Intensity Measure Type: PGA, PGV, PGD, SA, IA, RSD, or MMI';
COMMENT ON COLUMN hazard_curve.imls IS 'Intensity Measure Levels common to this set of hazard curves';
COMMENT ON COLUMN hazard_curve.statistics IS 'Statistic type, one of:
    - Mean     (mean)
    - Quantile (quantile)';
COMMENT ON COLUMN hazard_curve.quantile IS 'The quantile for quantile statistical data.';
COMMENT ON COLUMN hazard_curve.sa_period IS 'Spectral Acceleration period; only relevent when imt = SA';
COMMENT ON COLUMN hazard_curve.sa_damping IS 'Spectral Acceleration damping; only relevent when imt = SA';


-- Hazard curve node data.
CREATE TABLE hazard_curve_data (
    id SERIAL PRIMARY KEY,
    hazard_curve_id INTEGER NOT NULL,
    -- Probabilities of exceedence
    poes float[] NOT NULL,
    -- Copied from lt_realization.
    -- This was added for performance reasons, so we can get the weight
    -- without having to join `lt_realization`.
    -- `weight` can be null, if the weight is implicit.
    weight NUMERIC
) TABLESPACE hzrdr_ts;
SELECT AddGeometryColumn('hzrdr', 'hazard_curve_data', 'location', 4326, 'POINT', 2);
ALTER TABLE hazard_curve_data ALTER COLUMN location SET NOT NULL;

COMMENT ON TABLE hazard_curve_data IS 'Holds location/POE data for hazard curves';
COMMENT ON COLUMN hazard_curve_data.hazard_curve_id IS 'The foreign key to the hazard curve record for this node.';
COMMENT ON COLUMN hazard_curve_data.poes IS 'Probabilities of exceedence.';

-- Stochastic Event Set Collection
-- A container for all of the Stochastic Event Sets in a given
-- logic tree realization.
CREATE TABLE ses_collection (
    id SERIAL PRIMARY KEY,
    output_id INTEGER NOT NULL,
    lt_model_id INTEGER, -- can be null for scenario
    ordinal INTEGER NOT NULL
) TABLESPACE hzrdr_ts;

-- A rupture as part of a Stochastic Event Set Collection.
-- Ruptures will have different geometrical definitions, depending on whether
-- the event was generated from a point/area source or a simple/complex fault
-- source.
CREATE TABLE probabilistic_rupture (
    id SERIAL PRIMARY KEY,
    ses_collection_id INTEGER NOT NULL,
    rake float NOT NULL,
    is_from_fault_source BOOLEAN NOT NULL,
    is_multi_surface BOOLEAN NOT NULL,
    surface BYTEA NOT NULL,
    magnitude float NOT NULL,
    _hypocenter FLOAT[3],
    site_indices INTEGER[],
    trt_model_id INTEGER NOT NULL
) TABLESPACE hzrdr_ts;


CREATE TABLE ses_rupture (
    id SERIAL PRIMARY KEY,
    ses_id INTEGER NOT NULL,
    rupture_id INTEGER NOT NULL,  -- FK to probabilistic_rupture.id
    tag VARCHAR NOT NULL,
    seed INTEGER NOT NULL
) TABLESPACE hzrdr_ts;

-- gmf_rupture table ---------------------------------------------------
CREATE TABLE gmf_rupture (
   id SERIAL PRIMARY KEY,
   rupture_id INTEGER NOT NULL,  -- fk to ses_rupture
   gsim TEXT NOT NULL,
   imt TEXT NOT NULL, -- fk to imt
   ground_motion_field FLOAT[] NOT NULL
) TABLESPACE hzrdr_ts;

CREATE TABLE gmf (
    id SERIAL PRIMARY KEY,
    output_id INTEGER NOT NULL,  -- FK to output.id
    -- FK to lt_realization.id
    lt_realization_id INTEGER  -- can be NULL for scenario calculator
) TABLESPACE hzrdr_ts;

CREATE TABLE gmf_data (
    id SERIAL PRIMARY KEY,
    gmf_id INTEGER NOT NULL, -- fk -> gmf
    task_no INTEGER NOT NULL,
    imt VARCHAR NOT NULL,
        CONSTRAINT hazard_curve_imt
        CHECK(imt in ('PGA', 'PGV', 'PGD', 'SA', 'IA', 'RSD', 'MMI')),
    sa_period float,
        CONSTRAINT gmf_sa_period
        CHECK(
            ((imt = 'SA') AND (sa_period IS NOT NULL))
            OR ((imt != 'SA') AND (sa_period IS NULL))),
    sa_damping float,
        CONSTRAINT gmf_sa_damping
        CHECK(
            ((imt = 'SA') AND (sa_damping IS NOT NULL))
            OR ((imt != 'SA') AND (sa_damping IS NULL))),
    gmvs float[] NOT NULL,
    rupture_ids int[],
    site_id INTEGER NOT NULL -- fk -> hazard_site
) TABLESPACE hzrdr_ts;


CREATE TABLE disagg_result (
    id SERIAL PRIMARY KEY,
    output_id INTEGER NOT NULL,  -- FK to output
    lt_realization_id INTEGER NOT NULL,  -- FK to lt_realization
    investigation_time float NOT NULL,
    imt VARCHAR NOT NULL CONSTRAINT disagg_result_imt
        CHECK(imt in ('PGA', 'PGV', 'PGD', 'SA', 'IA', 'RSD', 'MMI')),
    iml float NOT NULL,
    poe float NOT NULL,
    sa_period float CONSTRAINT disagg_result_sa_period
        CHECK(
            ((imt = 'SA') AND (sa_period IS NOT NULL))
            OR ((imt != 'SA') AND (sa_period IS NULL))),
    sa_damping float CONSTRAINT disagg_result_sa_damping
        CHECK(
            ((imt = 'SA') AND (sa_damping IS NOT NULL))
            OR ((imt != 'SA') AND (sa_damping IS NULL))),
    mag_bin_edges float[] NOT NULL,
    dist_bin_edges float[] NOT NULL,
    lon_bin_edges float[] NOT NULL,
    lat_bin_edges float[] NOT NULL,
    eps_bin_edges float[] NOT NULL,
    trts VARCHAR[] NOT NULL,
    matrix bytea NOT NULL
) TABLESPACE hzrdr_ts;
SELECT AddGeometryColumn('hzrdr', 'disagg_result', 'location', 4326, 'POINT', 2);
ALTER TABLE disagg_result ALTER COLUMN location SET NOT NULL;

-- Uniform Hazard Spectra
--
-- A collection of Uniform Hazard Spectrum which share a set of periods.
-- A UH Spectrum has a PoE (Probability of Exceedence) and is conceptually
-- composed of a set of 2D matrices, 1 matrix per site/point of interest.
-- Each 2D matrix has a number of rows equal to `realizations` and a number of
-- columns equal to the number of `periods`.
CREATE TABLE uhs (
    id SERIAL PRIMARY KEY,
    output_id INTEGER NOT NULL,
    lt_realization_id INTEGER,  -- lt_realization FK, only required for non-statistical curves
    investigation_time float NOT NULL,
    poe float NOT NULL,
    periods float[] NOT NULL,
    statistics VARCHAR CONSTRAINT uhs_statistics
        CHECK(statistics IS NULL OR
              statistics IN ('mean', 'quantile')),
    -- Quantile value (only for "quantile" statistics)
    quantile float CONSTRAINT uhs_quantile_value
        CHECK(
            ((statistics = 'quantile') AND (quantile IS NOT NULL))
            OR (((statistics != 'quantile') AND (quantile IS NULL))))
) TABLESPACE hzrdr_ts;


-- Uniform Hazard Spectrum
--
-- * "Uniform" meaning "the same PoE"
-- * "Spectrum" because it covers a range/band of periods/frequencies
CREATE TABLE uhs_data (
    id SERIAL PRIMARY KEY,
    uhs_id INTEGER NOT NULL,
    imls float[] NOT NULL
) TABLESPACE hzrdr_ts;
SELECT AddGeometryColumn('hzrdr', 'uhs_data', 'location', 4326, 'POINT', 2);
ALTER TABLE uhs_data ALTER COLUMN location SET NOT NULL;

-- logic tree source models
CREATE TABLE lt_source_model (
   id SERIAL PRIMARY KEY,
   hazard_calculation_id INTEGER NOT NULL,
   ordinal INTEGER NOT NULL,
    -- A list of the logic tree branchIDs
   sm_lt_path VARCHAR[] NOT NULL,
   sm_name VARCHAR NOT NULL,
   weight NUMERIC
) TABLESPACE hzrdr_ts;

-- logic tree source model infos
CREATE TABLE trt_model (
   id SERIAL PRIMARY KEY,
   lt_model_id INTEGER, -- fk to lt_source_model
   tectonic_region_type TEXT NOT NULL,
   num_sources INTEGER NOT NULL,
   num_ruptures INTEGER NOT NULL,
   min_mag FLOAT NOT NULL,
   max_mag FLOAT NOT NULL,
   gsims TEXT[]
) TABLESPACE hzrdr_ts;

-- specific source info
CREATE TABLE source_info (
  id SERIAL,
  trt_model_id INTEGER NOT NULL,
  source_id TEXT NOT NULL,
  source_class TEXT NOT NULL,
  num_sites INTEGER NOT NULL,
  num_ruptures INTEGER NOT NULL,
  occ_ruptures INTEGER NOT NULL,
  calc_time FLOAT NOT NULL
) TABLESPACE hzrdr_ts;

-- associations logic tree realizations <-> trt_models
CREATE TABLE assoc_lt_rlz_trt_model(
id SERIAL,
rlz_id INTEGER NOT NULL,
trt_model_id INTEGER NOT NULL,
gsim TEXT NOT NULL
) TABLESPACE hzrdr_ts;

-- keep track of logic tree realization progress for a given calculation
CREATE TABLE lt_realization (
    id SERIAL PRIMARY KEY,
    lt_model_id INTEGER NOT NULL, -- fk lt_mode.id
    ordinal INTEGER NOT NULL,
    weight NUMERIC, -- path weight
    gsim_lt_path VARCHAR[] NOT NULL -- list of the logic tree branchIDs
) TABLESPACE hzrdr_ts;


-- Loss map data.
CREATE TABLE loss_map (
    id SERIAL PRIMARY KEY,
    output_id INTEGER NOT NULL, -- FK to output.id
    loss_type VARCHAR NOT NULL,
    hazard_output_id INTEGER NULL,
    insured BOOLEAN NOT NULL DEFAULT false,
    -- poe is significant only for non-scenario calculations
    poe float NULL CONSTRAINT valid_poe
        CHECK (poe IS NULL OR (poe >= 0.0) AND (poe <= 1.0)),
    statistics VARCHAR CONSTRAINT loss_map_statistics
        CHECK(statistics IS NULL OR
              statistics IN ('mean', 'quantile')),
    -- Quantile value (only for "quantile" statistics)
    quantile float CONSTRAINT loss_map_quantile_value
        CHECK(
            ((statistics = 'quantile') AND (quantile IS NOT NULL))
            OR (((statistics != 'quantile') AND (quantile IS NULL))))
) TABLESPACE riskr_ts;

COMMENT ON TABLE loss_map IS 'Holds metadata for loss maps.';
COMMENT ON COLUMN loss_map.output_id IS 'The foreign key to the output record that represents the corresponding loss map.';
COMMENT ON COLUMN loss_map.poe IS 'Probability of exceedance (for probabilistic loss maps)';


CREATE TABLE loss_map_data (
    id SERIAL PRIMARY KEY,
    loss_map_id INTEGER NOT NULL, -- FK to loss_map.id
    asset_ref VARCHAR NOT NULL,
    -- for scenario calculations value correspond to a mean value
    value float NOT NULL,
    -- for non-scenario calculations std_dev is NULL
    std_dev float NULL
) TABLESPACE riskr_ts;
SELECT AddGeometryColumn('riskr', 'loss_map_data', 'location', 4326, 'POINT', 2);
ALTER TABLE loss_map_data ALTER COLUMN location SET NOT NULL;

COMMENT ON TABLE loss_map_data IS 'Holds an asset, its position and a value plus (for non-scenario maps) the standard deviation for its loss.';
COMMENT ON COLUMN loss_map_data.loss_map_id IS 'The foreign key to the loss map';
COMMENT ON COLUMN loss_map_data.asset_ref IS 'The asset reference';
COMMENT ON COLUMN loss_map_data.location IS 'The position of the asset';
COMMENT ON COLUMN loss_map_data.value IS 'The value of the loss';
COMMENT ON COLUMN loss_map_data.std_dev IS 'The standard deviation of the loss (for scenario maps, for non-scenario maps the standard deviation is NULL)';


-- Loss fraction data.
CREATE TABLE loss_fraction (
    id SERIAL PRIMARY KEY,
    output_id INTEGER NOT NULL, -- FK to output.id
    loss_type VARCHAR NOT NULL,
    hazard_output_id INTEGER NULL,
    variable VARCHAR NOT NULL,
    statistics VARCHAR CONSTRAINT loss_fraction_statistics
        CHECK(statistics IS NULL OR
              statistics IN ('mean', 'quantile')),
    -- Quantile value (only for "quantile" statistics)
    quantile float CONSTRAINT loss_fraction_quantile_value
        CHECK(
            ((statistics = 'quantile') AND (quantile IS NOT NULL))
            OR (((statistics != 'quantile') AND (quantile IS NULL)))),
    -- poe is significant only for classical calculations
    poe FLOAT NULL CONSTRAINT valid_poe
        CHECK (poe IS NULL OR (poe >= 0.0) AND (poe <= 1.0))
) TABLESPACE riskr_ts;

CREATE TABLE loss_fraction_data (
    id SERIAL PRIMARY KEY,
    loss_fraction_id INTEGER NOT NULL, -- FK to loss_fraction.id
    --- Holds a serialized representation of `variable`. if `variable`
    --- is a taxonomy, then `value` is a string representing an asset
    --- taxonomy
    value VARCHAR NOT NULL,
    absolute_loss FLOAT NOT NULL
) TABLESPACE riskr_ts;
SELECT AddGeometryColumn('riskr', 'loss_fraction_data', 'location', 4326, 'POINT', 2);
ALTER TABLE loss_fraction_data ALTER COLUMN location SET NOT NULL;


-- Aggregate Loss.
CREATE TABLE aggregate_loss (
    id SERIAL PRIMARY KEY,
    output_id INTEGER NOT NULL, -- FK to output.id
    loss_type VARCHAR NOT NULL,
    insured BOOLEAN NOT NULL DEFAULT false,
    mean float NOT NULL,
    std_dev float NULL
) TABLESPACE riskr_ts;


-- Event Loss table.
CREATE TABLE event_loss (
    id SERIAL PRIMARY KEY,

    -- FK to output.id. The corresponding row must have
    -- output_type == event_loss
    output_id INTEGER NOT NULL,
    hazard_output_id INTEGER NULL,
    loss_type VARCHAR NOT NULL
) TABLESPACE riskr_ts;


-- Event Loss table.
CREATE TABLE event_loss_data (
    id SERIAL PRIMARY KEY,

    event_loss_id INTEGER NOT NULL,
    rupture_id INTEGER NOT NULL, -- FK to ses_rupture.id
    aggregate_loss float NOT NULL
) TABLESPACE riskr_ts;


-- Loss curve.
CREATE TABLE loss_curve (
    id SERIAL PRIMARY KEY,
    output_id INTEGER NOT NULL,
    loss_type VARCHAR NOT NULL,
    hazard_output_id INTEGER NULL,
    aggregate BOOLEAN NOT NULL DEFAULT false,
    insured BOOLEAN NOT NULL DEFAULT false,

    statistics VARCHAR CONSTRAINT loss_curve_statistics
        CHECK(statistics IS NULL OR
              statistics IN ('mean', 'quantile')),
    -- Quantile value (only for "quantile" statistics)
    quantile float CONSTRAINT loss_curve_quantile_value
        CHECK(
            ((statistics = 'quantile') AND (quantile IS NOT NULL))
            OR (((statistics != 'quantile') AND (quantile IS NULL))))
) TABLESPACE riskr_ts;

COMMENT ON TABLE loss_curve IS 'Holds the parameters common to a set of loss curves.';
COMMENT ON COLUMN loss_curve.output_id IS 'The foreign key to the output record that represents the corresponding loss curve.';
COMMENT ON COLUMN loss_curve.aggregate IS 'Is the curve an aggregate curve?';

-- Loss curve data. Holds the asset, its position and value plus the calculated
-- curve.
CREATE TABLE loss_curve_data (
    id SERIAL PRIMARY KEY,
    loss_curve_id INTEGER NOT NULL,

    asset_ref VARCHAR NOT NULL,
    -- needed to compute absolute losses in the export phase
    asset_value float NOT NULL,
    loss_ratios float[] NOT NULL,
    -- Probabilities of exceedence
    poes float[] NOT NULL,

    -- Average Loss ratio
    average_loss_ratio FLOAT NOT NULL,

    -- Average Loss ratio
    stddev_loss_ratio FLOAT
) TABLESPACE riskr_ts;
SELECT AddGeometryColumn('riskr', 'loss_curve_data', 'location', 4326, 'POINT',
                         2);
ALTER TABLE loss_curve_data ALTER COLUMN location SET NOT NULL;

COMMENT ON TABLE loss_curve_data IS 'Holds the probabilities of exceedance for a given loss curve.';
COMMENT ON COLUMN loss_curve_data.loss_curve_id IS 'The foreign key to the curve record to which the loss curve data belongs';
COMMENT ON COLUMN loss_curve_data.asset_ref IS 'The asset id';
COMMENT ON COLUMN loss_curve_data.location IS 'The position of the asset';
COMMENT ON COLUMN loss_curve_data.asset_value IS 'The value of the asset';
COMMENT ON COLUMN loss_curve_data.loss_ratios IS 'Loss ratios';
COMMENT ON COLUMN loss_curve_data.poes IS 'Probabilities of exceedence';


-- Aggregate loss curve data.  Holds the probability of exceedence of certain
-- levels of losses for the whole exposure model.
CREATE TABLE aggregate_loss_curve_data (
    id SERIAL PRIMARY KEY,
    loss_curve_id INTEGER NOT NULL,

    losses float[] NOT NULL CONSTRAINT non_negative_losses
        CHECK (0 <= ALL(losses)),
    -- Probabilities of exceedence
    poes float[] NOT NULL,

    -- Absolute Loss
    average_loss FLOAT NOT NULL,

    -- StdDev of losses
    stddev_loss FLOAT
) TABLESPACE riskr_ts;

COMMENT ON TABLE aggregate_loss_curve_data IS 'Holds the probabilities of exceedance for the whole exposure model.';
COMMENT ON COLUMN aggregate_loss_curve_data.loss_curve_id IS 'The foreign key to the loss curve record to which the aggregate loss curve data belongs';
COMMENT ON COLUMN aggregate_loss_curve_data.losses IS 'Losses';
COMMENT ON COLUMN aggregate_loss_curve_data.poes IS 'Probabilities of exceedence';

-- Benefit-cost ratio distribution
CREATE TABLE bcr_distribution (
    id SERIAL PRIMARY KEY,
    output_id INTEGER NOT NULL, -- FK to output.id
    loss_type VARCHAR NOT NULL,
    hazard_output_id INTEGER NULL
) TABLESPACE riskr_ts;

COMMENT ON TABLE bcr_distribution IS 'Holds metadata for the benefit-cost ratio distribution';
COMMENT ON COLUMN bcr_distribution.output_id IS 'The foreign key to the output record that represents the corresponding BCR distribution.';


CREATE TABLE bcr_distribution_data (
    id SERIAL PRIMARY KEY,
    bcr_distribution_id INTEGER NOT NULL, -- FK to bcr_distribution.id
    asset_ref VARCHAR NOT NULL,
    average_annual_loss_original float NOT NULL,
    average_annual_loss_retrofitted float NOT NULL,
    bcr float NOT NULL
) TABLESPACE riskr_ts;
SELECT AddGeometryColumn('riskr', 'bcr_distribution_data', 'location', 4326, 'POINT', 2);
ALTER TABLE bcr_distribution_data ALTER COLUMN location SET NOT NULL;

COMMENT ON TABLE bcr_distribution_data IS 'Holds the actual data for the BCR distribution';
COMMENT ON COLUMN bcr_distribution_data.bcr_distribution_id IS 'The foreign key to the record to which the BCR distribution data belongs';
COMMENT ON COLUMN bcr_distribution_data.asset_ref IS 'The asset id';
COMMENT ON COLUMN bcr_distribution_data.average_annual_loss_original IS 'The Expected annual loss computed by using the original model';
COMMENT ON COLUMN bcr_distribution_data.average_annual_loss_retrofitted IS 'The Expected annual loss computed by using the retrofitted model';
COMMENT ON COLUMN bcr_distribution_data.bcr IS 'The actual benefit-cost ratio';


CREATE TABLE dmg_state (
    id SERIAL PRIMARY KEY,
    risk_calculation_id INTEGER NOT NULL REFERENCES risk_calculation,
    dmg_state VARCHAR NOT NULL,
    lsi SMALLINT NOT NULL CHECK(lsi >= 0),
    UNIQUE (risk_calculation_id, dmg_state),
    UNIQUE (risk_calculation_id, lsi)
) TABLESPACE riskr_ts;

COMMENT ON TABLE dmg_state IS 'Holds the damage_states associated to a given output';


-- Damage Distribution Per Asset
CREATE TABLE dmg_dist_per_asset (
    id SERIAL PRIMARY KEY,
    dmg_state_id INTEGER NOT NULL REFERENCES dmg_state,
    exposure_data_id INTEGER NOT NULL,  -- FK to exposure_data.id
    mean float NOT NULL,
    stddev float NOT NULL
) TABLESPACE riskr_ts;


-- Damage Distrubtion Per Taxonomy
CREATE TABLE dmg_dist_per_taxonomy (
    id SERIAL PRIMARY KEY,
    dmg_state_id INTEGER NOT NULL REFERENCES dmg_state,
    taxonomy VARCHAR NOT NULL,
    mean float NOT NULL,
    stddev float NOT NULL
) TABLESPACE riskr_ts;


-- Total Damage Distribution
CREATE TABLE dmg_dist_total (
    id SERIAL PRIMARY KEY,
    dmg_state_id INTEGER NOT NULL REFERENCES dmg_state,
    mean float NOT NULL,
    stddev float NOT NULL
) TABLESPACE riskr_ts;


-- Exposure model
-- Abbreviations:
--      coco: contents cost
--      reco: retrofitting cost
--      stco: structural cost
CREATE TABLE exposure_model (
    id SERIAL PRIMARY KEY,
    -- Associates the risk exposure model with an input record
    job_id INTEGER NOT NULL,
    name VARCHAR NOT NULL,
    description VARCHAR,
    -- the taxonomy system used to classify the assets
    taxonomy_source VARCHAR,
    -- e.g. "buildings", "bridges" etc.
    category VARCHAR NOT NULL,

    -- area type
    area_type VARCHAR CONSTRAINT area_type_value
        CHECK(area_type IS NULL OR area_type = 'per_asset'
              OR area_type = 'aggregated'),

    -- area unit
    area_unit VARCHAR,

    deductible_absolute BOOLEAN DEFAULT TRUE,
    insurance_limit_absolute BOOLEAN DEFAULT TRUE

) TABLESPACE riski_ts;

COMMENT ON TABLE exposure_model IS 'A risk exposure model';
COMMENT ON COLUMN exposure_model.area_type IS 'area type. one of: aggregated or per_asset';
COMMENT ON COLUMN exposure_model.area_unit IS 'area unit of measure e.g. sqm';
COMMENT ON COLUMN exposure_model.category IS 'The risk category modelled';
COMMENT ON COLUMN exposure_model.description IS 'An optional description of the risk exposure model at hand';

COMMENT ON COLUMN exposure_model.name IS 'The exposure model name';

COMMENT ON COLUMN exposure_model.taxonomy_source IS 'the taxonomy system used to classify the assets';


-- Cost Conversion table
CREATE TABLE cost_type (
    id SERIAL PRIMARY KEY,
    exposure_model_id INTEGER NOT NULL,

    name VARCHAR NOT NULL,
    conversion VARCHAR NOT NULL CONSTRAINT conversion_value
        CHECK(conversion = 'per_asset'
              OR conversion = 'per_area'
              OR conversion = 'aggregated'),
    unit VARCHAR,
    retrofitted_conversion VARCHAR CONSTRAINT retrofitted_conversion_value
        CHECK(retrofitted_conversion IS NULL
              OR retrofitted_conversion = 'per_asset'
              OR retrofitted_conversion = 'per_area'
              OR retrofitted_conversion = 'aggregated'),
    retrofitted_unit VARCHAR
) TABLESPACE riski_ts;


-- Per-asset exposure data
CREATE TABLE exposure_data (
    id SERIAL PRIMARY KEY,
    exposure_model_id INTEGER NOT NULL,
    -- the asset reference is unique within an exposure model.
    asset_ref VARCHAR NOT NULL,

    -- vulnerability function reference
    taxonomy VARCHAR NOT NULL,

    -- number of assets, people etc.
    number_of_units float CONSTRAINT units_value CHECK(number_of_units >= 0.0),
    area float CONSTRAINT area_value CHECK(area >= 0.0),

    site GEOGRAPHY(point) NOT NULL,
    UNIQUE (exposure_model_id, asset_ref)
) TABLESPACE riski_ts;

COMMENT ON TABLE exposure_data IS 'Per-asset risk exposure data';
COMMENT ON COLUMN exposure_data.area IS 'asset area';
COMMENT ON COLUMN exposure_data.asset_ref IS 'A unique identifier (within the exposure model) for the asset at hand';
COMMENT ON COLUMN exposure_data.exposure_model_id IS 'Foreign key to the exposure model';
COMMENT ON COLUMN exposure_data.number_of_units IS 'number of assets, people etc.';
COMMENT ON COLUMN exposure_data.taxonomy IS 'A reference to the taxonomy that should be used for the asset at hand';


CREATE TABLE cost (
    id SERIAL PRIMARY KEY,
    exposure_data_id INTEGER NOT NULL,
    cost_type_id INTEGER NOT NULL,
    converted_cost float NOT NULL CONSTRAINT converted_cost_value
         CHECK(converted_cost >= 0.0),
    converted_retrofitted_cost float CONSTRAINT converted_retrofitted_cost_value
         CHECK(converted_retrofitted_cost >= 0.0),
    deductible_absolute float CONSTRAINT deductible_value
         CHECK(deductible_absolute >= 0.0),
    insurance_limit_absolute float CONSTRAINT insurance_limit_value
         CHECK(insurance_limit_absolute >= 0.0),
    UNIQUE (exposure_data_id, cost_type_id)
) TABLESPACE riski_ts;


CREATE TABLE occupancy (
    id SERIAL PRIMARY KEY,
    exposure_data_id INTEGER NOT NULL,
    period VARCHAR NOT NULL,
    occupants float NOT NULL
) TABLESPACE riski_ts;

COMMENT ON TABLE occupancy IS 'Occupancy for a given exposure data set';
COMMENT ON COLUMN occupancy.exposure_data_id IS 'Foreign key to the exposure data set to which the occupancy data applies.';
COMMENT ON COLUMN occupancy.period IS 'describes the occupancy data e.g. day, night etc.';
COMMENT ON COLUMN occupancy.occupants IS 'number of occupants';


-- calculation points of interest with parameters extracted from site_model or hc
CREATE TABLE hazard_site (
    id SERIAL PRIMARY KEY,
    hazard_calculation_id INTEGER NOT NULL,
    location GEOGRAPHY(point) NOT NULL
) TABLESPACE hzrdi_ts;
