#!/bin/bash
. config.ini

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

cat /dev/null > temp.sql
for i in $( less tempversions.txt )
do
echo "DROP DATABASE IF EXISTS $dbbasename$i;" >> temp.sql
done 
mysql -P $mysqlport -h $mysqlhost -u $mysqluser --password=$mysqlpass < temp.sql
rm temp.sql
