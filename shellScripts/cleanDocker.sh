#!/bin/bash

if [ $# -ne 1 ] 
then
	echo "cleanDocker.sh called with incorrect number of arguments."
	echo "cleanDocker.sh <StagePath> "
	echo "For example; cleanDocker.sh /plm/pnnas/ppic/users/<staging path>"
	exit 1
fi

STAGE_DIR=$1

rm -rf ${STAGE_DIR}/dockerfile || { exit 1;}
# Dont clean all - only clean container created for running translator commands.
# Dont clean container for license server
#docker rm -v -f $(docker ps -qa) || { exit 1;} 
