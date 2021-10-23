#!/bin/bash
#####################
# configurable definitions
hostsfile=/etc/hosts
redirect="127.0.0.1"
######################

## Some definitions that shouldn't be changed
user=`whoami`

if [ $user = "root" ]
then
another="Yes"
while [ $another = "Yes" ]
do
site2bblocked=`zenity --entry \
--title="Block Site" \
--text="Enter site to be blocked.
DO NOT ENTER http:// !!!"`
if [ $site2bblocked ]
then
another=`zenity --list \
--title="Another site?" \
--column="Would you like to enter another site?" "Yes" "No"`
else
another="No"
fi

echo "$redirect $site2bblocked" >> $hostsfile
done
else
zenity --info --text="You need to be root to run this"
fi

return 0
