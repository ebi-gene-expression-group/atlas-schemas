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
  load_date TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
  last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
  title VARCHAR(500),
  pubmed_ids VARCHAR(255),
  dois VARCHAR(255)
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

CREATE TABLE exp_design
(
    experiment_accession VARCHAR(255)
        CONSTRAINT exp_design_k
            REFERENCES experiment (accession)
            ON DELETE CASCADE,
    run VARCHAR(50),
    sample_type char(50)
        CONSTRAINT exp_desing_sample_type_check
            check (sample_type = ANY (ARRAY['characteristic'::bpchar, 'factor'::bpchar])),
    sample VARCHAR(255),
    sample_value VARCHAR(255),
    ontology_url VARCHAR(255),
    CONSTRAINT exp_design_pk
        UNIQUE (experiment_accession, sample_type, sample_value)
);

CREATE TABLE exp_design_column_sequence
(
    experiment_accession VARCHAR(255) NOT NULL
        CONSTRAINT column_sequence_pk
            UNIQUE
        CONSTRAINT exp_design_column_sequence_fk
            REFERENCES experiment (accession)
            ON DELETE CASCADE,
    columns_sequence text[]
);
