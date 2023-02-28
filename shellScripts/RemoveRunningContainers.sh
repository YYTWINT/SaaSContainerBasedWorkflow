#!/bin/bash

# This script deletes all running continers except license server container "saltd_container"

for containerId in `docker ps -a | grep -v "saltd_container" | awk 'NR>1 {print $1}'`
do
	echo "Removing container with ID $containerId"
	docker rm -v -f $containerId
done

exit 0