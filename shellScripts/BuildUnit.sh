#!/bin/bash

if [ $# -ne 1 ] 
then
	echo "BuildUnit.sh called with incorrect number of arguments."
	echo "BuildUnit.sh <UnitPath>"
	echo "For example; BuildUnit.sh /plm/pnnas/ppic/users/<unit_name>"
	exit 1
fi

UNIT_PATH=$1

/usr/site/devop_tools/bin/unit run ${UNIT_PATH} /usr/site/devop_tools/bin/dt cli set -C -A NX1003887
/usr/site/devop_tools/bin/unit run ${UNIT_PATH} b 
/usr/site/devop_tools/bin/unit run ${UNIT_PATH} b image ugtopv

/usr/site/devop_tools/bin/unit run ${UNIT_PATH} b product TranslatorWorker
/usr/site/devop_tools/bin/unit run ${UNIT_PATH} b product validate_worker TranslatorWorker
