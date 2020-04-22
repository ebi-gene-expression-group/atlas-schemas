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

CREATE TABLE scxa_cell_group
(
  id SERIAL not null PRIMARY KEY,
  experiment_accession VARCHAR(255) NOT NULL,
  variable VARCHAR(255) NOT NULL,
  value VARCHAR(255) NOT NULL,
  UNIQUE (experiment_accession, variable, value)  
);

CREATE TABLE scxa_cell_group_membership
(
  experiment_accession VARCHAR(255) NOT NULL,
  cell_id VARCHAR(255) NOT NULL,
  cell_group_id integer references scxa_cell_group(id)
  CONSTRAINT scxa_cell_clusters_experiment_accession_cell_id_cell_group_id_pk
  PRIMARY KEY (experiment_accession, cell_id, cell_group_id)
);

CREATE TABLE scxa_cell_group_marker_genes
(
  gene_id VARCHAR(255) NOT NULL,
  cell_group_id integer references scxa_cell_group(id)
  marker_probability DOUBLE PRECISION,
  CONSTRAINT scxa_cell_group_marker_genes_pkey
  PRIMARY KEY (gene_id, cell_group_id)
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
