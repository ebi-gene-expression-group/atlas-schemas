#!/usr/bin/env bash

scriptDir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export testsDir=$scriptDir
export PATH=$scriptDir/../flyway:$scriptDir/../tests:$PATH

# For analytics loading testing
USER=$(echo $dbConnection | sed s+postgresql://++ | sed 's+:.*++')
PASS=$(echo $dbConnection | sed s+postgresql://++ | sed 's+.*:\(.*\)\@.*+\1+')
HOST=$(echo $dbConnection | sed 's+.*\@\(.*\)/.*+\1+')
DB=$(echo $dbConnection | sed 's+.*/\(.*\)+\1+')

# SCXA
flyway migrate -schemas='scxa' -url=jdbc:postgresql://${HOST}:5432/${DB} -user=${USER} -password=${PASS} -locations=filesystem:$( pwd )/usr/local/flyway/scxa

# GXA
flyway migrate -schemas='gxa' -url=jdbc:postgresql://${HOST}:5432/${DB} -user=${USER} -password=${PASS} -locations=filesystem:$( pwd )/usr/local/flyway/gxa

if [ "$#" -eq 0 ]; then
	bats --tap "$(dirname "${BASH_SOURCE[0]}")"
else
	bats "$@"
fi
