#!/bin/sh

folder="$1"
for entry in "$folder"/*.sql
do
  echo "$$$@@@@@@@@@@"
  echo "$entry"
  echo "@@@@@@@@@@"
  cat $entry
done
