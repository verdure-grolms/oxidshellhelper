#!/usr/bin/bash
# Show the decoded values of the config
 
# Copyright (C) 2015 Thamm IT GmbH <shops@thamm-it.de>

# 

# Depending on the directory you put this scipt in and the directory oxid
# resides in you need to adjust the location of the oxid configuration file.

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

mysql -u $dbUser -h $dbHost -p$dbPwd -e 'SELECT `oxconfig`.`OXVARNAME` AS `oxvarname`, `oxconfig`.`OXVARTYPE` AS `oxvartype`, DECODE(`oxconfig`.`OXVARVALUE`,"fq45QS09_fqyx09239QQ") AS `oxvarvalue` FROM `oxconfig`' $dbName > config`date +%Y%m%d-%H%M`.tsv

