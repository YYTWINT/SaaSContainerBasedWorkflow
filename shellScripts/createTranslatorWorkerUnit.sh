#!/bin/bash

if [ $# -ne 2 ] 
then
	echo "createTranslatorWorkerUnit.sh called with incorrect number of arguments."
	echo "createTranslatorWorkerUnit.sh <NXVersion> <UnitPath>"
	echo "For example; createTranslatorWorkerUnit.sh nx2206.latest /plm/pnnas/ppic/users/<unit_name>"
	exit 1
fi

NX_RELEASE=$1
UNIT_PATH=$2
/usr/site/devop_tools/bin/unit add -b -p @${NX_RELEASE} -t DEV -w SUB ${UNIT_PATH} -R y -O y -DO_LINK_OPT y
