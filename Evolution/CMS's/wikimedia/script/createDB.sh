#!/bin/bash
echo "LOADING CONFIGURATION FROM config.ini FILE"
. config.ini

echo "CHECKING CONFIGURATION..."
if [ -z "$dbbasename" ]; then
echo "SET DBBASENAME IN THE config FILE";
exit
fi

if [ -z "$mysqlpass" ]; then
echo "SET MYSQL PASSWORD IN THE config FILE";                                   
exit
fi

if [ -z "$mysqluser" ]; then
echo "SET MYSQL USER IN THE config FILE";                                   
exit
fi

if [ -z "$mysqlhost" ]; then
echo "SET MYSQL HOST IN THE config FILE";                                   
exit
fi

echo "BASENAME $dbbasename"
echo "CONFIGURATION OK..."

cat /dev/null > temp.sql
for i in $( less tempversions.txt )
do
echo "CREATE DATABASE IF NOT EXISTS $dbbasename$i;"
echo "CREATE DATABASE IF NOT EXISTS $dbbasename$i;" >> temp.sql
done 

echo "CREATING DBs INTO THE MySQL DBMS"
mysql -P $mysqlport -h $mysqlhost -u $mysqluser --password=$mysqlpass < temp.sql
rm temp.sql

echo "ALL DB CREATED IN MySQL. LOADING SCHEMAS..."

for i in $( less tempversions.txt )
do
echo "-- WORKING ON: wikipedia version $i --"
mysql -P $mysqlport -h $mysqlhost -u $mysqluser --password=$mysqlpass $dbbasename$i < ../schemata/schema_$i.sql
echo " ---- ---- ----- ---- ----- ----- ---- "
echo ""
done
echo "DONE"
