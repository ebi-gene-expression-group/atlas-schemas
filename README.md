# Expression Atlas schemas

Schemas for the database and SolrCloud servers used by [Expression Atlas](https://www.ebi.ac.uk/gxa) and [Single Cell
Expression Atlas](https://www.ebi.ac.uk/gxa/sc).

This is a central repository used by the web application to bootstrap the embedded database and Solr server in the
testing environment, and to initialise a fresh (PostgreSQL) database and SolrCloud cluster to be used by either flavour
of Expression Atlas.

In the `db` directory there is a `shared-schema.sql` file that is needed by both Expression Atlas and Single Cell
Expression Atlas, used to display array designs and design elements of a gene in the [bioentity information
card](https://github.com/ebi-gene-expression-group/atlas-bioentity-information).

## Migrations

We use [Flyway](https://flywaydb.org/) to version-control both single cell and bulk Expression Atlas databases. To
apply new migrations to a database, either from `gxa` or `scxa`, applied to bulk Expression Atlas and Single Cell
Expression Atlas, respectively, run the following command (fill in the variables as needed):
```bash
flyway migrate -url=jdbc:postgresql://${HOST}:5432/${DB} -user=${USER} -password=${PASSWORD} -locations=filesystem:`pwd`
```

The [`info`](https://flywaydb.org/documentation/command/info) and
[`repair`](https://flywaydb.org/documentation/command/repair) commands are helpful to troubleshoot issues (e.g.
checksum mismatches).
