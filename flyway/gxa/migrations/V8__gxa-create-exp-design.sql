CREATE TABLE exp_design
(
    accession VARCHAR(255)
        CONSTRAINT exp_design_k
            REFERENCES experiment (accession)
            ON DELETE CASCADE,
    marray VARCHAR(255),
    sample VARCHAR(255),
    annot_type char(50)
        CONSTRAINT exp_design_annot_type_check
            CHECK (annot_type = ANY (ARRAY['characteristic'::bpchar, 'factor'::bpchar])),
    annot VARCHAR(255),
    annot_value VARCHAR(255),
    annot_ont_URI VARCHAR(255),
    CONSTRAINT exp_design_pk
        UNIQUE (accession, sample, annot_type)
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