
#/bin/bash

echo  "LOAD CONFIGURATION FROM THE config FILE"
. config.ini 

echo  "CHECKING CONFIGURATION..."
if [ -z "$svnurl" ]; then 
	echo "SET THE SVN URL IN THE config FILE";
	exit;
fi
echo "CONFIGURATION OK. PROCEEDING IN THE FILE DOWNLOADS, IT MIGHT TAKE A WHILE..."

if [ -z "$2" ]; then
   if [ -z "$3" ]; then
	svn log --username $2 --password $3 -r0:HEAD --verbose $svnurl | grep " |" | sed 's/r\([0-9]*\).*/\1/' > tempraw.txt
   else
	svn log --username $2 --password "" -r0:HEAD --verbose $svnurl | grep " |" | sed 's/r\([0-9]*\).*/\1/' > tempraw.txt
   fi
else
   svn log -r 0:HEAD --verbose $svnurl | grep " |" | sed 's/r\([0-9]*\).*/\1/' > tempraw.txt
fi

cat /dev/null > tempversions.txt

# ADD ZEROES TO HAVE ORDERED VERSIONS WHEN CONSIDERING THEM AS STRINGS
for a in $( less tempraw.txt )
do
printf "%06i\n" "$a" >> tempversions.txt;
done

# DOWLOAD THE ACTUAL SCHEMAS
for a in $( less tempversions.txt )
do
echo "$a"
if [ -z "$svnuser" ]; then
   if [ -z "$svnpass" ]; then
	 svn export --username $svnuser --password $svnpass -r $a $svnurl ../schemata/schema_$a.sql
   else
	svn export --username $svnuser --password "" -r $a $svnurl ../schemata/schema_$a.sql
   fi
else
svn export -r $a $svnurl ../schemata/schema_$a.sql
fi
done

echo "DONE"
