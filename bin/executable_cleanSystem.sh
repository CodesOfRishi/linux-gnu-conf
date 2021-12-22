#!/bin/env bash

echo
echo "!! This script cleans up many files from many places of the file system."
echo "It is recommended to check out the script before executing it, to know what resources & files it can remove!"
echo 
echo -n "Do you want to continue to execute the script (y/n): "
read decision

case "$decision" in
y|Y)
	;;
n|N)
	echo "Approval to execute the script denied!"
	exit 0
	;;
*)
	echo "Invalid input!"
	exit 1
esac


#Check the Drive Space Used by Cached Files
du -sh /var/cache/apt/archives

#Clean all the log file
#for logs in `find /var/log -type f`;  do > $logs; done

logs=`find /var/log -type f`
for i in $logs
do
> $i
done

#Getting rid of partial packages
apt-get clean && apt-get autoclean
apt-get remove --purge -y software-properties-common

#Getting rid of no longer required packages
apt-get autoremove -y


#Getting rid of orphaned packages
deborphan | xargs sudo apt-get -y remove --purge

#Free up space by clean out the cached packages
apt-get clean

# Remove the Trash
rm -rf /home/*/.local/share/Trash/*/**
rm -rf /root/.local/share/Trash/*/**

echo "Cleaning complete!"
