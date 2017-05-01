#!/bin/bash

if [ "$1" == "run" ]
then
    EXIT_STATUS=$(docker run --name cryptotrade -v `pwd`:/cryptotrade \
    matthewsedam/chapel:latest /bin/sh -c "cd /cryptotrade; make; echo; \
    build/cryptotrade")
else
    EXIT_STATUS=$(docker run --name cryptotrade -v `pwd`:/cryptotrade \
    matthewsedam/chapel:latest /bin/sh -c "cd /cryptotrade; make $1")
fi

echo
echo "$EXIT_STATUS"
echo

docker stop cryptotrade
docker rm cryptotrade

if [[ "$EXIT_STATUS" == *"fail"* ]]
then
    EXIT_STATUS=1
else
    EXIT_STATUS=0
fi

exit $EXIT_STATUS
