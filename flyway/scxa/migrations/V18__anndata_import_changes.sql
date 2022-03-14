-- Create a table holding info on a dimension reduction, most of which was previously in scxa_coords 

CREATE TABLE scxa_dimension_reduction
(
    id SERIAL not null PRIMARY KEY,
    experiment_accession VARCHAR(255) NOT NULL,
    method VARCHAR(255) NOT NULL,
    parameterisation VARCHAR(255) NOT NULL,
    priority SMALLINT DEFAULT 0 NOT NULL
);

CREATE INDEX scxa_dimension_reduction_experiment_accession_method_param_priority ON scxa_dimension_reduction(experiment_accession, method, parameterisation, priority);
CREATE INDEX scxa_dimension_reduction_id ON scxa_dimension_reduction(id);

-- Remove those columns from scxa_coords

DROP INDEX scxa_coords_experiment_accession_method_param;

ALTER TABLE scxa_coords
  ADD COLUMN dimension_reduction_id SMALLINT REFERENCES scxa_dimension_reduction(id) ON DELETE CASCADE,
  DROP COLUMN experiment_accession,
  DROP COLUMN method,
  DROP COLUMN parameterisation;

-- Add the index for the new foreign key on the coords table
CREATE_INDEX scxa_coords_dimension_reduction_id ON scxa_coords(dimension_reduction_id);

