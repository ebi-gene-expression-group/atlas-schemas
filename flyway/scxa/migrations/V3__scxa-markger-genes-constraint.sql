ALTER TABLE scxa_marker_genes DROP CONSTRAINT scxa_marker_genes_experiment_accession_gene_id_k_pk;

ALTER TABLE scxa_marker_genes ADD CONSTRAINT scxa_marker_genes_experiment_accession_gene_id_k_cluster_id_pk PRIMARY KEY (experiment_accession, gene_id, k, cluster_id);
