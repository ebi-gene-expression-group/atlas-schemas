# Expression Atlas schemas

Schemas for the database and SolrCloud servers used by [Expression Atlas](https://www.ebi.ac.uk/gxa) and [Single Cell
Expression Atlas](https://www.ebi.ac.uk/gxa/sc).

This is a central repository used by the web application to bootstrap the embedded database and Solr server for
testing, and to initialise a fresh (PostgreSQL) database and SolrCloud cluster to be used by either or both flavours of
Expression Atlas.

In the `db` directory there is a `shared-schema.sql` file that is needed by both Expression Atlas and Single Cell
Expression Atlas, used to display array designs and design elements of a gene in the [bioentity information
card](https://github.com/ebi-gene-expression-group/atlas-bioentity-information).
