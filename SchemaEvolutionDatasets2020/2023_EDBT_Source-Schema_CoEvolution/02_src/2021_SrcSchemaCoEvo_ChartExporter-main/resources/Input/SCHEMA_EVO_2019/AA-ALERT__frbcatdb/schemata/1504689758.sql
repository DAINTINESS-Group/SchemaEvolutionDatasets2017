-- -----------------------------------------------------
-- Table authors
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS authors (
  id SERIAL PRIMARY KEY,
  ivorn VARCHAR(255) NOT NULL UNIQUE,
  title VARCHAR(255),
  logo_url VARCHAR(255),
  short_name VARCHAR(255),
  contact_name VARCHAR(255),
  contact_email VARCHAR(255),
  contact_phone VARCHAR(255),
  other_information TEXT);

-- -----------------------------------------------------
-- Table publications
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS publications (
  id SERIAL PRIMARY KEY,
  type VARCHAR(128),
  reference TEXT,
  link TEXT,
  description TEXT);

-- -----------------------------------------------------
-- Table frbs
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS frbs (
  id SERIAL PRIMARY KEY,
  author_id INTEGER NOT NULL REFERENCES authors(id),
  name VARCHAR(255) NOT NULL UNIQUE,
  utc TIMESTAMP NOT NULL,
  private BOOLEAN NOT NULL DEFAULT FALSE);
CREATE INDEX frbs_author_id_fk ON frbs (author_id);

-- -----------------------------------------------------
-- Table frbs_have_publications
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS frbs_have_publications (
  frb_id INTEGER NOT NULL REFERENCES frbs (id),
  pub_id INTEGER NOT NULL REFERENCES publications (id),
  PRIMARY KEY (frb_id, pub_id));

-- -----------------------------------------------------
-- Table frbs_notes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS frbs_notes (
  id  SERIAL PRIMARY KEY,
  frb_id INTEGER NOT NULL REFERENCES frbs (id),
  last_modified TIMESTAMP NOT NULL,
  author VARCHAR(32) NOT NULL,
  note TEXT);
CREATE INDEX frbs_notes_frb_id_fk ON frbs_notes (frb_id);

-- -----------------------------------------------------
-- Table observations
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS observations (
  id  SERIAL PRIMARY KEY,
  frb_id INTEGER NOT NULL REFERENCES frbs (id),
  author_id INTEGER NOT NULL REFERENCES authors (id),
  type TEXT,
  telescope VARCHAR(128) NOT NULL,
  utc TIMESTAMP NOT NULL,
  data_link TEXT,
  detected BOOLEAN NOT NULL DEFAULT TRUE,
  verified BOOLEAN NOT NULL DEFAULT FALSE,
  UNIQUE (frb_id, telescope, utc));
CREATE INDEX observations_author_id_fk ON observations (author_id);
CREATE INDEX observations_frb_id_fk ON observations (frb_id);

-- -----------------------------------------------------
-- Table observations_have_publications
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS observations_have_publications (
  obs_id INTEGER NOT NULL REFERENCES observations (id),
  pub_id INTEGER NOT NULL REFERENCES publications (id),
  PRIMARY KEY (obs_id, pub_id));

-- -----------------------------------------------------
-- Table observations_notes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS observations_notes (
  id  SERIAL PRIMARY KEY,
  obs_id INTEGER NOT NULL REFERENCES observations (id),
  last_modified TIMESTAMP NOT NULL,
  author VARCHAR(32) NOT NULL,
  note TEXT);
CREATE INDEX observations_notes_obs_id_fk ON observations_notes (obs_id);

-- -----------------------------------------------------
-- Table radio_observations_params
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS radio_observations_params (
  id  SERIAL PRIMARY KEY,
  obs_id INTEGER NOT NULL REFERENCES observations (id),
  author_id INTEGER NOT NULL REFERENCES authors (id),
  settings_id VARCHAR(255) NOT NULL,
  receiver VARCHAR(255),
  backend VARCHAR(255),
  beam VARCHAR(8),
  beam_semi_major_axis DOUBLE PRECISION,
  beam_semi_minor_axis DOUBLE PRECISION,
  beam_rotation_angle DOUBLE PRECISION,
  raj VARCHAR(16) NOT NULL,
  decj VARCHAR(16) NOT NULL,
  gl DOUBLE PRECISION,
  gb DOUBLE PRECISION,
  pointing_error DOUBLE PRECISION,
  sampling_time DOUBLE PRECISION,
  bandwidth DOUBLE PRECISION,
  centre_frequency DOUBLE PRECISION,
  npol INTEGER,
  channel_bandwidth DOUBLE PRECISION,
  bits_per_sample SMALLINT,
  gain DOUBLE PRECISION,
  tsys DOUBLE PRECISION,
  mw_dm_limit DOUBLE PRECISION,
  UNIQUE (obs_id, settings_id));
CREATE INDEX radio_observations_params_author_id_fk ON radio_observations_params (author_id);
CREATE INDEX radio_observations_params_obs_id_fk ON radio_observations_params (obs_id);
COMMENT ON COLUMN radio_observations_params.pointing_error IS 'pointing accuracy in arcsec';
COMMENT ON COLUMN radio_observations_params.bandwidth IS 'in MHz';
COMMENT ON COLUMN radio_observations_params.centre_frequency IS 'in MHz';
COMMENT ON COLUMN radio_observations_params.channel_bandwidth IS 'in MHz';
COMMENT ON COLUMN radio_observations_params.gain IS 'in K/Jy';
COMMENT ON COLUMN radio_observations_params.tsys IS 'in K';

-- -----------------------------------------------------
-- Table radio_observations_params_have_publications
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS radio_observations_params_have_publications (
  rop_id INTEGER NOT NULL REFERENCES radio_observations_params (id),
  pub_id INTEGER NOT NULL REFERENCES publications (id),
  PRIMARY KEY (rop_id, pub_id));


-- -----------------------------------------------------
-- Table radio_observations_params_notes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS radio_observations_params_notes (
  id  SERIAL PRIMARY KEY,
  rop_id INTEGER NOT NULL REFERENCES radio_observations_params (id),
  last_modified TIMESTAMP NOT NULL,
  author VARCHAR(32) NOT NULL,
  note TEXT);
CREATE INDEX radio_observations_params_notes_rop_id_fk ON radio_observations_params_notes (rop_id);

-- -----------------------------------------------------
-- Table radio_measured_params
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS radio_measured_params (
  id  SERIAL PRIMARY KEY,
  rop_id INTEGER NOT NULL REFERENCES radio_observations_params (id),
  author_id INTEGER NOT NULL REFERENCES authors (id),
  voevent_ivorn VARCHAR(255) NOT NULL UNIQUE,
  voevent_xml TEXT NOT NULL,
  dm DOUBLE PRECISION NOT NULL,
  dm_error DOUBLE PRECISION,
  snr DOUBLE PRECISION NOT NULL,
  width DOUBLE PRECISION NOT NULL,
  width_error_upper DOUBLE PRECISION,
  width_error_lower DOUBLE PRECISION,
  flux DOUBLE PRECISION,
  flux_prefix VARCHAR(255),
  flux_error_upper DOUBLE PRECISION,
  flux_error_lower DOUBLE PRECISION,
  flux_calibrated BOOLEAN,
  dm_index DOUBLE PRECISION,
  dm_index_error DOUBLE PRECISION,
  scattering_index DOUBLE PRECISION,
  scattering_index_error DOUBLE PRECISION,
  scattering DOUBLE PRECISION,
  scattering_error DOUBLE PRECISION,
  linear_poln_frac DOUBLE PRECISION,
  linear_poln_frac_error DOUBLE PRECISION,
  circular_poln_frac DOUBLE PRECISION,
  circular_poln_frac_error DOUBLE PRECISION,
  spectral_index DOUBLE PRECISION,
  spectral_index_error DOUBLE PRECISION,
  rm DOUBLE PRECISION,
  rm_error DOUBLE PRECISION,
  redshift_inferred DOUBLE PRECISION,
  redshift_host DOUBLE PRECISION,
  rank INTEGER);
CREATE INDEX radio_measured_params_author_id_fk ON radio_measured_params (author_id);
CREATE INDEX radio_measured_params_rop_id_fk ON radio_measured_params (rop_id);
COMMENT ON COLUMN radio_measured_params.scattering IS 'At 1 GHz';

-- -----------------------------------------------------
-- Table radio_measured_params_have_publications
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS radio_measured_params_have_publications (
  rmp_id INTEGER NOT NULL REFERENCES radio_measured_params (id),
  pub_id INTEGER NOT NULL REFERENCES publications (id),
  PRIMARY KEY (rmp_id, pub_id));

-- -----------------------------------------------------
-- Table radio_measured_params_notes
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS radio_measured_params_notes (
  id  SERIAL PRIMARY KEY,
  rmp_id INTEGER NOT NULL REFERENCES radio_measured_params (id),
  last_modified TIMESTAMP NOT NULL,
  author VARCHAR(32) NOT NULL,
  note TEXT);
CREATE INDEX radio_measured_params_notes_rmp_id_fk ON radio_measured_params_notes (rmp_id);

-- -----------------------------------------------------
-- Table radio_images
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS radio_images (
  id  SERIAL PRIMARY KEY,
  title TEXT,
  caption TEXT,
  image BYTEA);

-- -----------------------------------------------------
-- Table radio_images_have_radio_measured_params
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS radio_images_have_radio_measured_params (
  radio_image_id INTEGER NOT NULL REFERENCES radio_images (id),
  rmp_id INTEGER NOT NULL REFERENCES radio_measured_params (id),
  PRIMARY KEY (radio_image_id, rmp_id));
