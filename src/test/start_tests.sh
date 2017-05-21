#!/bin/bash

echo "Starting Testing"
echo

EXIT_STATUS=$(find . -name '*.chpl' -exec ./processTest.sh {} \; 2>&1)
echo "$EXIT_STATUS"

echo
echo "Finished Testing"

if [[ "$EXIT_STATUS" == *"fail"* ]]
then
    EXIT_STATUS_NUM=1
elif [[ "$EXIT_STATUS" == *"FAIL"* ]]
then
    EXIT_STATUS_NUM=1
elif [[ "$EXIT_STATUS" == *"err"* ]]
then
    EXIT_STATUS_NUM=1
elif [[ "$EXIT_STATUS" == *"ERR"* ]]
then
    EXIT_STATUS_NUM=1
else
    EXIT_STATUS_NUM=0
fi

exit $EXIT_STATUS_NUM
