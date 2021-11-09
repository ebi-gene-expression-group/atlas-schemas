FROM quay.io/ebigxa/atlas-schemas-base:1.0
# based on u-mamba
# To modify base dependencies,
# edit https://github.com/ebi-gene-expression-group/atlas-containers/tree/master/atlas-schemas-base

COPY tests /usr/local/tests
COPY flyway/scxa /usr/local/flyway/scxa
COPY flyway/gxa /usr/local/flyway/gxa
