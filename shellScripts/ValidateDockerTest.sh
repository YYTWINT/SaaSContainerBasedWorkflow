#!/bin/bash

if [ $# -ne 1 ]
then
        echo "ValidateDockerTest.sh called with incorrect number of arguments."
        echo "ValidateDockerTest.sh <productName>"
        echo "For example; ValidateDockerTest.sh <Step>"
        exit 1
fi

PRODUCT_NAME=$1

TEST="/volume/Results"
GOLD="/volume/Gold"

# Run JTCompare inside Docker and capture the result
docker exec jtcompare_container /bin/bash /volume/JTCompare_1.0.2/runcompare.sh "${GOLD}" "${TEST}"
RESULT=$?

if [ $RESULT -ne 0 ]; then
    echo "❌ JT Comparison failed."
    exit 1
else
    echo "✅ JT Comparison passed."
    exit 0
fi