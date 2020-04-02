create table collections
(
	coll_id serial not null,
	name varchar default 255 not null,
	description varchar default 255 not null
);

comment on table collections is 'SCXA Experiment collections';

create unique index experiment_accession_uindex
	on experiment (accession);

alter table experiment
	add constraint experiment_pk
		primary key (accession);

create table experiment2collection
(
	exp_acc varchar not null
		constraint experiment2collection_experiment_accession_fk
			references experiment (accession)
				on delete cascade,
	coll_id int not null
		constraint experiment2collection_collections_coll_id_fk
			references collections (coll_id)
				on delete cascade,
	constraint experiment2collection_pk
		primary key (exp_acc, coll_id)
);

create index experiment2collection_coll_id_index
	on experiment2collection (coll_id);

create index experiment2collection_exp_acc_index
	on experiment2collection (exp_acc);
