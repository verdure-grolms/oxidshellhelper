# oxidshellhelper
Collection of Shell-Scripts for use with oxid

##dumpwithoutviews
Sometimes you want to dump the mysql database without the views Oxid uses for language support.
Unfortunately mysqldump doesn't support an exclusion based on table type.
There is a way to ignore tables/views with specified name.
This script asks mysql for a list of all views and ignores them in the dump.
To circumvent the need to put the database credentials the script searches for them in the oxid configuration.
So you almost certainly have to adjust the location in the script to fit your installation.
This script was inspired by the solution posted at http://www.marmalade.de/magazin/2014/11/oxid-datenbankdump-ohne-views/