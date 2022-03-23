create table exp_design
(
    sample varchar(255) not null,
    annot_value varchar(255) not null,
    annot_ont_URI varchar(255),
    column_definition integer not null
        constraint exp_design_exp_design_column_sequence_id_fk
            references exp_design_column_sequence
            on delete cascade,
    id serial not null
        constraint exp_design_pk
            primary key
);

create table exp_design_column
(
    experiment_accession varchar(255) not null
        constraint exp_design_column_sequence_experiment_accession_fk
            references experiment (accession)
            on delete cascade,
    column_name varchar(255) not null,
    column_type boolean not null,
    column_order integer not null,
    id serial not null
        constraint exp_design_column_sequence_pk
            primary key
);