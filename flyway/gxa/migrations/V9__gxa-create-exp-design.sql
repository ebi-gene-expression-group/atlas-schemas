CREATE TABLE gxa_marker_gene
(
    experiment_accession VARCHAR(255) CHECK (experiment_accession LIKE 'E-%') NOT NULL,
    assay VARCHAR(255) NOT NULL,
    assay_id VARCHAR(255) NOT NULL,
    gene_id VARCHAR(255) NOT NULL,
    gene_name VARCHAR(255) NOT NULL,
    marker_gene_rank INTEGER,
    expression_level FLOAT NOT NULL,
    expression_unit VARCHAR(8) NOT NULL,
    number_assays INTEGER NOT NULL,
    specificity_score FLOAT,
    CONSTRAINT gxa_marker_gene_pkey PRIMARY KEY (experiment_accession, assay, gene_id)
);
