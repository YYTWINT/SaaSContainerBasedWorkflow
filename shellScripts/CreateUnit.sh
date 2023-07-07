#!/bin/bash

if [ $# -ne 3 ] 
then
	echo "CreateUnit.sh called with incorrect number of arguments."
	echo "CreateUnit.sh <NXVersion> <UnitPath> <HCflag>"
	echo "For example; CreateUnit.sh nx2206.latest /plm/pnnas/ppic/users/<unit_name> <false/true>"
	exit 1
fi

NX_RELEASE=$1
UNIT_PATH=$2
HC_FLAG=$3

if [ ${HC_FLAG} == "false" ]
then
	/usr/site/devop_tools/bin/unit add -b -p @${NX_RELEASE} -t DEV -w SUB ${UNIT_PATH} -R y -O y -DO_LINK_OPT y
else
	/usr/site/devop_tools/bin/unit add -b -p @${NX_RELEASE} -t DEV -w SUB ${UNIT_PATH} -R y -O y -DO_LINK_OPT y

	initFile=${UNIT_PATH}/init.def
	sed -i 's/DO_TARI_RECOMPILES.*/DO_TARI_RECOMPILES       1/g' $initFile
	sed -i 's/DO_SOURCE_RECOMPILES.*/DO_SOURCE_RECOMPILES       1/g' $initFile
	sed -i 's/DO_LINK_OPT.*/DO_LINK_OPT       1/g' $initFile
	sed -i 's/DO_DEBUG.*/DO_DEBUG       0/g' $initFile
	sed -i 's/DO_QAZ.*/DO_QAZ       1/g' $initFile
	sed -i 's/DO_DLL_COMPARISON.*/DO_DLL_COMPARISON       1/g' $initFile
fi
