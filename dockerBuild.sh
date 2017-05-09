#!/bin/bash

if [ "$1" == "run" ];
then
    EXIT_STATUS=$(docker run --name cryptotrade -v `pwd`:/cryptotrade \
    matthewsedam/chapel:latest /bin/sh -c "cd /cryptotrade; make; echo; \
    build/cryptotrade")
elif [ "$1" == "test" ];
then
    EXIT_STATUS=$(docker run --name cryptotrade -v `pwd`:/cryptotrade \
    matthewsedam/chapel:latest /bin/sh -c "cd /cryptotrade; make test")
else
    EXIT_STATUS=$(docker run --name cryptotrade -v `pwd`:/cryptotrade \
    matthewsedam/chapel:latest /bin/sh -c "cd /cryptotrade; make $1")
fi

echo
echo "$EXIT_STATUS"
echo

docker stop cryptotrade >/dev/null
docker rm cryptotrade >/dev/null

if [[ "$EXIT_STATUS" == *"fail"* ]];
then
    EXIT_STATUS=1
elif [[ "$EXIT_STATUS" == *"FAIL"* ]];
then
    EXIT_STATUS=1
else
    EXIT_STATUS=0
fi

exit $EXIT_STATUS
