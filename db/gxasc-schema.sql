SET search_path=atlas3dev;

CREATE TABLE scxa_marker_genes
(
  gene_id VARCHAR(255) NOT NULL,
  experiment_accession VARCHAR(255) NOT NULL,
  k INTEGER NOT NULL,
  cluster_id INTEGER NOT NULL,
  marker_probability DOUBLE PRECISION,
  CONSTRAINT marker_genes_pkey
  PRIMARY KEY (gene_id, experiment_accession, k, cluster_id)
);

CREATE TABLE scxa_experiment
(
  accession VARCHAR(255) NOT NULL
    CONSTRAINT scxa_experiment_pkey
    PRIMARY KEY,
  type VARCHAR(50) NOT NULL,
  species VARCHAR(255) NOT NULL,
  access_key CHAR(36) NOT NULL,
  private BOOLEAN DEFAULT TRUE,
  last_update TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
  pubmed_ids VARCHAR(255),
  title VARCHAR(500),
  dois VARCHAR(255)
);

CREATE TABLE scxa_tsne
(
  experiment_accession VARCHAR(255) NOT NULL,
  cell_id VARCHAR(255) NOT NULL,
  x DOUBLE PRECISION,
  y DOUBLE PRECISION,
  perplexity INTEGER NOT NULL,
  CONSTRAINT scxa_tsne_experiment_accession_cell_id_perplexity_pk
  PRIMARY KEY (experiment_accession, cell_id, perplexity)
);

CREATE TABLE scxa_analytics
(
  experiment_accession VARCHAR(255) NOT NULL,
  gene_id VARCHAR(255) NOT NULL,
  cell_id VARCHAR(255) NOT NULL,
  expression_level DOUBLE PRECISION,
  CONSTRAINT scxa_analytics_gene_id_experiment_accession_cell_id_pk
  PRIMARY KEY (gene_id, experiment_accession, cell_id)
);

CREATE TABLE scxa_cell_clusters
(
  experiment_accession VARCHAR(255) NOT NULL,
  cell_id VARCHAR(255) NOT NULL,
  k INTEGER NOT NULL,
  cluster_id INTEGER NOT NULL,
  CONSTRAINT scxa_cell_clusters_experiment_accession_k_cell_id_pk
  PRIMARY KEY (experiment_accession, k, cell_id)
);

CREATE VIEW scxa_public_experiment AS
(
  SELECT
    scxa_experiment.accession,
    scxa_experiment.type,
    scxa_experiment.last_update
  FROM scxa_experiment
  WHERE scxa_experiment.private IS FALSE
);

-- This table replaces the materialised view used in the Postgres DB
CREATE TABLE scxa_marker_gene_stats
(
  experiment_accession VARCHAR(255) NOT NULL,
  gene_id VARCHAR(255) NOT NULL,
  k_where_marker INTEGER NOT NULL,
  cluster_id_where_marker INTEGER NOT NULL,
  cluster_id INTEGER NOT NULL,
  marker_p_value DOUBLE PRECISION NOT NULL,
  mean_expression DOUBLE PRECISION NOT NULL,
  median_expression DOUBLE PRECISION NOT NULL,
  CONSTRAINT marker_gene_stats_pkey
  PRIMARY KEY (experiment_accession, gene_id, k_where_marker, cluster_id)
);