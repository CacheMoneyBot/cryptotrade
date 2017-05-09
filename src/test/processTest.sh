#!/bin/bash

chpl $1 -o ./test
./test
rm ./test
