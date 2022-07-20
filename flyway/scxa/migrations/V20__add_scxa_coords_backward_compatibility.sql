-- Rename latest scxa_coords table with '_latest' to CREATE old scxa_coords table with old columns for the backward compatibility

ALTER TABLE scxa_coords RENAME TO scxa_coords_latest;

-- CREATE old scxa_coords table with all five columns

CREATE TABLE if NOT EXISTS scxa_coords
(
    experiment_accession VARCHAR(255) NOT NULL,
    method VARCHAR(255) NOT NULL,
    cell_id VARCHAR(255) NOT NULL,
    x DOUBLE PRECISION,
    y DOUBLE PRECISION,
    parameterisation jsonb NOT NULL);

CREATE index if NOT EXISTS scxa_coords_parameterisation
	ON scxa_coords USING gin (parameterisation);

CREATE index if NOT EXISTS scxa_coords_experiment_accession_method
	ON scxa_coords (experiment_accession, method);

