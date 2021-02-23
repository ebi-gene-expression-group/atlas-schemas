ALTER TABLE scxa_coords ALTER COLUMN json_parameterisation SET NOT NULL;
ALTER TABLE scxa_coords DROP COLUMN parameterisation;

CREATE INDEX scxa_coords_json_parameterisation ON scxa_coords using gin(json_parameterisation);
