ALTER TABLE scxa_coords ALTER COLUMN json_parameterisation SET NOT NULL;

CREATE INDEX scxa_coords_json_parameterisation ON scxa_coords using gin(json_parameterisation);
