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
    column_name VARCHAR(255),
    column_type CHAR(50)
        CONSTRAINT column_type_check
            CHECK (column_type = ANY (ARRAY['characteristic'::bpchar, 'factor'::bpchar])),
    column_order INTEGER
);