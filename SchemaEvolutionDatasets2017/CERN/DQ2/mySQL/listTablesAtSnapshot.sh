#!/bin/bash

#Look at the file of the first parameter $1, grep for CREATE TABLE, and cut everything except for the columns 3 up to 3
#
grep 'CREATE TABLE' $1 | cut -d ' ' -f3-3 | sort > $1_TABLES_TEST.txt

