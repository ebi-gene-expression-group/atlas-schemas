-- Create a table holding info on a dimension reduction, most of which was previously in scxa_coords 

CREATE TABLE scxa_dimension_reduction
(
    id SERIAL not null PRIMARY KEY,
    experiment_accession VARCHAR(255) NOT NULL,
    method VARCHAR(255) NOT NULL,
    parameterisation JSONB DEFAULT NULL,
    priority SMALLINT DEFAULT 0 NOT NULL
);

CREATE INDEX scxa_dimension_reduction_experiment_accession_method_param_priority ON scxa_dimension_reduction(experiment_accession, method, parameterisation, priority);
CREATE INDEX scxa_dimension_reduction_id ON scxa_dimension_reduction(id);

-- Populate with data from the old table

INSERT INTO scxa_dimension_reduction (experiment_accession, method, parameterisation) 
  SELECT DISTINCT experiment_accession, method, parameterisation FROM scxa_coords;  

-- Add new column

ALTER TABLE scxa_coords
  ADD COLUMN dimension_reduction_id SMALLINT REFERENCES scxa_dimension_reduction(id) ON DELETE CASCADE;

-- Add the index for the new foreign key on the coords table
CREATE INDEX scxa_coords_dimension_reduction_id ON scxa_coords(dimension_reduction_id);

-- Add the correct references to the new table

INSERT INTO scxa_coords (dimension_reduction_id)
  SELECT id
  FROM scxa_coords LEFT JOIN scxa_dimension_reduction AS sdr ON 
    scxa_coords.experiment_accession = sdr.experiment_accession AND
    scxa_coords.method = sdr.method AND
    scxa_coords.parameterisation = sdr.parameterisation;

-- Remove those columns from scxa_coords

ALTER TABLE scxa_coords
  DROP COLUMN experiment_accession,
  DROP COLUMN method,
  DROP COLUMN parameterisation;





