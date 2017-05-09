#!/bin/bash

flags=""
find ../ -type d >inc.temp
while IFS= read line; do flags="$flags -I$line"; done <inc.temp
rm inc.temp

file="../"${1#*/}
file=${file//Test/}

chpl $file $1 -o ./test $flags
./test
rm ./test
