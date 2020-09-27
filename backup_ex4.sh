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

#Added the 2> to get rid of the stderr message.
tar -czf $output $input 2> null.txt

echo -n "Files to be included:"
total_files $input
echo -n "Directories to be included:"
total_directories $input

echo "Backup of $input completed!"

echo "Details about the output backup file:"

ls -l $output
