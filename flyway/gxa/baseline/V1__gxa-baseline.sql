CREATE TABLE experiment
(
	accession varchar(255),
	type varchar(50),
	access_key char(36),
	private varchar(1),
	last_update timestamp,
	pubmed_ids varchar(255),
	title varchar(500),
	dois varchar(255)
);

CREATE TABLE experiment_organism
(
	organism varchar(255),
	experiment varchar(255),
	bioentity_organism varchar(1020)
);

CREATE TABLE rnaseq_bsln_ce_profiles
(
	experiment varchar(255),
	identifier varchar(255),
	ce_identifiers text
);

CREATE TABLE arraydesign
(
  accession VARCHAR(255) NOT NULL
    CONSTRAINT arraydesign_pkey
    PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE designelement_mapping
(
  designelement VARCHAR(255) NOT NULL,
  identifier VARCHAR(255) NOT NULL,
  type VARCHAR(50) NOT NULL,
  arraydesign VARCHAR(255) NOT NULL
    CONSTRAINT fk_dem_arraydesign
    REFERENCES arraydesign
    ON DELETE CASCADE
);

CREATE VIEW public_experiment AS
	SELECT accession, type, last_update
	FROM experiment WHERE private='F';