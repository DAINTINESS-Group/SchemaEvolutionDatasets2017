#!/bin/bash
. config.ini
. queries

mysql -h $mysqlhost -P $mysqlport -u $mysqluser --password=$mysqlpass -D "information_schema" -B -e "$tablecountquery" | grep "$dbbasename" > ../results/tablecountquery.dat
mysql -h $mysqlhost -P $mysqlport -u $mysqluser --password=$mysqlpass -D "information_schema" -B -e "$columncountquery"| grep "$dbbasename" > ../results/columncountquery.dat
mysql -h $mysqlhost -P $mysqlport -u $mysqluser --password=$mysqlpass -D "information_schema" -B -e "$tablelifetimequery"| grep "$dbbasename" > ../results/tablelifetimequery.dat
                                                                                               


