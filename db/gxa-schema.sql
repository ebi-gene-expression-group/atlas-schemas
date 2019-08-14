SET search_path=atlas3dev;

CREATE TABLE experiment
(
  accession VARCHAR(255) NOT NULL
    CONSTRAINT experiment_pkey
    PRIMARY KEY,
  type VARCHAR(50) NOT NULL,
  species VARCHAR(255),
  access_key CHAR(36) NOT NULL,
  private BOOLEAN,
  last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
  pubmed_ids VARCHAR(255),
  dois VARCHAR(255)
);

CREATE TABLE rnaseq_bsln_ce_profiles
(
  experiment VARCHAR(255) NOT NULL,
  identifier VARCHAR(255) NOT NULL,
  ce_identifiers TEXT NOT NULL,
  CONSTRAINT rnaseq_bsln_ce_profiles_pkey
  PRIMARY KEY (experiment, identifier)
);

CREATE VIEW public_experiment AS
(
  SELECT experiment.accession,
    experiment.type,
    experiment.last_update
  FROM experiment
  WHERE experiment.private = FALSE
);
