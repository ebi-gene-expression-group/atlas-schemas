CREATE TABLE gxa_marker_gene
(
    experiment_accession VARCHAR(255) CHECK (experiment_accession LIKE 'E-%') NOT NULL,
    assay VARCHAR(255) NOT NULL,
    gene_id VARCHAR(255) NOT NULL,
    specificity_score FLOAT,
    marker_gene_rank INTEGER,
    expression_unit VARCHAR(8) NOT NULL,
    expression_level FLOAT NOT NULL,
    gene_name VARCHAR(255) NOT NULL,
    CONSTRAINT gxa_marker_gene_pkey PRIMARY KEY (experiment_accession, assay, gene_id, expression_unit)
);
