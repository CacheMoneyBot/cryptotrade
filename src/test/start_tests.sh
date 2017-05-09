#!/bin/bash

echo "Starting Testing"
echo

find . -name '*.chpl' -exec ./processTest.sh {} \;

echo
echo "Finished Testing"
