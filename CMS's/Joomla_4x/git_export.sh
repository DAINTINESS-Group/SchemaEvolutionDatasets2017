#! /bin/bash

file_to_export=$1
path_to_export=$2
mkdir -p "$path_to_export"
hashes=($(git log --format="%H" $file_to_export))
dates=($(git log --format="%at" $file_to_export))
for i in ${!hashes[@]} ; do
  git show ${hashes[$i]}:$file_to_export > "$path_to_export/${dates[$i]}.sql"
done

