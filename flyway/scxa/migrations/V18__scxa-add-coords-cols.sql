ALTER TABLE scxa_coords
ADD COLUMN source VARCHAR(255) NOT NULL DEFAULT scxa,
ADD COLUMN default BOOLEAN NOT NULL DEFAULT FALSE;
