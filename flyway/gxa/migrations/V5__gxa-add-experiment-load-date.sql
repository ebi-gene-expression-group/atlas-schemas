ALTER TABLE experiment
ADD COLUMN load_date TIMESTAMP;

UPDATE experiment
SET load_date = last_update;
