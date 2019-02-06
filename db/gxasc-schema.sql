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

CREATE MATERIALIZED VIEW scxa_top_5_marker_genes_per_cluster AS
  (SELECT *
   FROM (SELECT ROW_NUMBER() OVER (PARTITION BY experiment_accession, k, cluster_id ORDER BY marker_probability ASC) AS r,
                markers.*
         FROM (SELECT * FROM scxa_marker_genes) markers) x
   WHERE x.r <= 5)
WITH DATA;

CREATE MATERIALIZED VIEW scxa_marker_gene_stats AS
  (SELECT aggregated.experiment_accession,
          aggregated.gene_id,
          aggregated.k_where_marker,
          aggregated.cluster_id_where_marker,
          aggregated.cluster_id,
          aggregated.marker_p_value,
          avg(aggregated.expression_level) AS mean_expression,
          percentile_cont(0.5) WITHIN GROUP (
          ORDER BY aggregated.expression_level
          )                                AS median_expression
   FROM (SELECT analytics.experiment_accession,
                analytics.gene_id,
                clusters.cluster_id,
                markers.k                  AS k_where_marker,
                markers.cluster_id         AS cluster_id_where_marker,
                markers.marker_probability AS marker_p_value,
                analytics.expression_level
         FROM scxa_analytics AS analytics
                JOIN scxa_top_5_marker_genes_per_cluster AS markers
                  ON analytics.experiment_accession = markers.experiment_accession
                       AND analytics.gene_id = markers.gene_id
                JOIN scxa_cell_clusters AS clusters ON analytics.experiment_accession = clusters.experiment_accession
                                                         AND analytics.cell_id = clusters.cell_id
                                                         AND clusters.k = markers.k) AS aggregated
   GROUP BY aggregated.experiment_accession, aggregated.gene_id,
            aggregated.k_where_marker, aggregated.cluster_id_where_marker,
            aggregated.cluster_id,
            aggregated.marker_p_value)
WITH DATA;
