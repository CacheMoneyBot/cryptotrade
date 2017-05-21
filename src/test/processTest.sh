#!/bin/bash

flags=""
find ../ -type d >inc.temp
while IFS= read line; do flags="$flags -I$line"; done <inc.temp
rm inc.temp

file=$(find ../ -name '*.chpl' ! -path '../main.chpl' ! -path '../test/*')

chpl $file $1 -o ./test $flags --no-warnings
./test
rm ./test
