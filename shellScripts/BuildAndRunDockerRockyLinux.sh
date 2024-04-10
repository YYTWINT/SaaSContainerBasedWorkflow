#!/bin/bash

if [ $# -ne 2 ] 
then
	echo "BuildAndRunDocker.sh called with incorrect number of arguments."
	echo "BuildAndRunDocker.sh <UnitPath> <StagePath> "
	echo "For example; BuildAndRunDocker.sh /plm/pnnas/ppic/users/<unit path> /plm/pnnas/ppic/users/<staging path>"
	exit 1
fi

UNIT_PATH=$1
STAGE_DIR=$2/TranslatorBinaries


INIT_DEF_FILE=${UNIT_PATH}/init.def
echo "INIT_DEF_FILE = $INIT_DEF_FILE"
stringarray=(`grep DMS_PARENT_BASELINE ${INIT_DEF_FILE} || { exit 1;}`)
NX_RELEASE=${stringarray[1]}
	
docker build -t trx22:$NX_RELEASE $STAGE_DIR -f $STAGE_DIR/dockerfile || { exit 1;} 

docker run --name nxjt_testrun_container -v /apps/JenkinsBase/docker:/volume --cpus="1" --memory="2g" trx22:$NX_RELEASE

#Now check for error in /volume/Logs/log.txt file
LOG_FILE=/apps/JenkinsBase/docker/Logs/log_pass.txt
errorCount=0

echo "Checking case for pass condition"

if [ -f $LOG_FILE ] 
then
	for failingCase in `grep -v ":0" $LOG_FILE | cut -d : -f 1`
	do
		echo "Docker test run failed for part : $failingCase"
		((errorCount++))
	done
	
	if [ $errorCount -ne 0 ]
	then
		echo "Number of tests failed for Docker test = $errorCount. Exiting with error."
		exit 1
	fi
else
	echo "Could not find log file $LOG_FILE"
	exit 1
fi

# Initialize a counter for non-zero lines
non_zero_lines=0

# Read each line of the file
while IFS= read -r line; do
    # Extract the value after the last ':'
    value=$(echo "$line" | awk -F':' '{print $NF}')
    
    # Check if the value is non-zero
    if [ "$value" -ne 0 ]; then
        # Increment the counter
        non_zero_lines=$((non_zero_lines + 1))
    fi
done < "$LOG_FILE"

# Output the result
echo "Number of lines with non-zero value after the last ':' is: $non_zero_lines"


LOG_FILE=/apps/JenkinsBase/docker/Logs/log_fail.txt
errorCount=0

echo "Checking case for fail condition"
if [ -f $LOG_FILE ] 
then
	for failingCase in `grep ":0" $LOG_FILE | cut -d : -f 1`
	do
		echo "Docker test run failed for part : $failingCase"
		((errorCount++))
	done
	
	if [ $errorCount -ne 0 ]
	then
		echo "Number of tests failed for Docker test = $errorCount. Exiting with error."
		exit 1
	fi
else
	echo "Could not find log file $LOG_FILE"
	exit 1
fi

