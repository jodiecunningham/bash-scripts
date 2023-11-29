#!/usr/bin/env bash

for i in $(grep -P "^[a-zA-Z]{3,4}$" /usr/share/dict/words|shuf|head -n 20);do echo $i$(grep -P "^[a-zA-Z]{3}$" /usr/share/dict/words|shuf|head -n 1);done
