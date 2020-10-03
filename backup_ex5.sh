#!/bin/bash
#This bash script is used to backup a user's Desktop directory to the Documents directory

#This gathers the username and the respective directory which will be backed up using the program.
user=$(whoami)
input=/c/Users/$user/Desktop
output=/c/Users/$user/Documents/${user}_desktop_$(date +%Y-%m-%d_%H%M%S).tar
 
#This function reports the total number of files for a given directory
function total_files {
	find $1 -type f | wc -l
}

#This function reports a totla number of directories for a given directory
function total_directories {
	find $1 -type d | wc -l
}

#This function calculates the total archived directories
function total_archived_directories {
	tar -tzf $1 | grep /$ | wc -l
}

#This function calculates the total archived files
function total_archived_files {
	tar -tzf $1 | grep -v /$ | wc -l
}

#Added the 2> to get rid of the stderr message.
tar -czf $output $input 2> null.txt

src_files=$( total_files $input )
src_directories=$( total_directories $input )

arch_files=$( total_archived_files $output )
arch_directories=$( total_archived_directories $output )

echo "Files to be included: $src_files"
echo "Directories to be included: $src_directories"
echo "Files archived: $arch_files"
echo "Directories archived: $arch_directories"

#Checks to see if the archive was completed correctly
if [ $src_files -eq $arch_files ]; then 
	echo "Backup of $input completed!"
	echo "Details about the output backup file"
	ls -l $output
else
	echo "Backup of $input failed"
fi
