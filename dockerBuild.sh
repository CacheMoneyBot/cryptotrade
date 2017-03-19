#!/bin/bash

if [ "$1" == "run" ]
then
    docker run --name cryptotrade -v `pwd`:/cryptotrade chapel/chapel:latest \
        /bin/sh -c "cd /cryptotrade; make; echo; build/cryptotrade; echo"
else
    docker run --name cryptotrade -v `pwd`:/cryptotrade chapel/chapel:latest \
        /bin/sh -c "cd /cryptotrade; make $1; echo"
fi

docker stop cryptotrade
docker rm cryptotrade
