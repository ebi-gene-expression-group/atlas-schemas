#!/usr/bin/env bash

scriptDir=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export testsDir=$scriptDir
export PATH=$scriptDir/../flyway:$scriptDir/../tests:$PATH


make_flyway_credentials(){
	dbConnection=$1
	schema=$2

	USER=$(echo $dbConnection | sed s+postgresql://++ | sed 's+:.*++')
	PASS=$(echo $dbConnection | sed s+postgresql://++ | sed 's+.*:\(.*\)\@.*+\1+')
	HOST=$(echo $dbConnection | sed 's+.*\@\(.*\)/.*+\1+')
	DB=$(echo $dbConnection | sed 's+.*/\(.*\)+\1+')

	flyway migrate -schemas=$schema -url=jdbc:postgresql://${HOST}:5432/${DB} -user=${USER} -password=${PASS} -locations=filesystem:$( pwd )/usr/local/flyway/${schema}

}

# SCXA
make_flyway_credentials 'postgresql://scxa:postgresPass@postgres/scxa-test' 'scxa'

# GXA
make_flyway_credentials 'postgresql://scxa:postgresPass@postgres/scxa-test' 'gxa'

if [ "$#" -eq 0 ]; then
	bats --tap "$(dirname "${BASH_SOURCE[0]}")"
else
	bats "$@"
fi
