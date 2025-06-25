CREATE TABLE gxa_marker_gene
(
    experiment_accession VARCHAR(255) CHECK (experiment_accession LIKE 'E-%') NOT NULL,
    assay VARCHAR(255) NOT NULL,
    gene_id VARCHAR(255) NOT NULL,
    gene_rank INTEGER NOT NULL,
    expression_value FLOAT NOT NULL,
    expression_unit VARCHAR(8) NOT NULL
);
