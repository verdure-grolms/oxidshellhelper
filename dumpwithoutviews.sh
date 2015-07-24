#!/usr/bin/bash
# Dump the mysql-database without views
 
# Copyright (C) 2015 Thamm IT GmbH <shops@thamm-it.de>

# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#location of the oxid configuration file
oxidconfig="oxid/config.inc.php"

#get parameters for database connection from oxid configuration file
dbHost=`grep dbHost $oxidconfig | grep -oE \'.*\'`
dbHost=${dbHost#"'"}
dbHost=${dbHost%"'"}

dbName=`grep dbName $oxidconfig | grep -oE \'.*\'`
dbName=${dbName#"'"}
dbName=${dbName%"'"}

dbUser=`grep dbUser $oxidconfig | grep -oE \'.*\'`
dbUser=${dbUser#"'"}
dbUser=${dbUser%"'"}

dbPwd=`grep dbPwd $oxidconfig | grep -oE \'.*\'`
dbPwd=${dbPwd#"'"}
dbPwd=${dbPwd%"'"}

#identify all views in selected database
ignorepart=""
for line in `mysql -u $dbUser -h $dbHost -p$dbPwd -e 'SHOW FULL TABLES WHERE Table_type = "VIEW"' $dbName | cut -f1 | grep -v "Tables_in_"`;
do
 ignorepart=$ignorepart" --ignore-table=$dbName."$line
done

#dump the database while ignoring the views to a file named with current date and time
mysqldump -u $dbUser -h $dbHost -p$dbPwd $ignorepart $dbName > dump`date +%Y%m%d-%H%M`.sql
