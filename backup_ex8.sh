#!/bin/bash
#This bash script is used to backup a user's Desktop directory to the Documents directory

function backup {
	#Checking to see if the user exists
	if [ -z $1 ]; then
		user=$(whoami)
	else
		if [ ! -d "/c/users/$1/Desktop" ]; then
		#I like that this informs the user of what is wrong instead of just erroring and exiting.
			echo "Requested $1 user desktop directory doesn't exist."
			exit 1
		fi
		user=$1
	fi

	#This gathers the username and the respective directory which will be backed up using the program.
	input=/c/Users/$user/Desktop
	#The use of the date here to automatically name the file with date and time is super helpful to let you know which file is most recent.
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

	#having the total number of files and directories archived be output can be helpful in knowing if your backup files are possibly getting too large.
	arch_files=$( total_archived_files $output )
	arch_directories=$( total_archived_directories $output )

	#Echoing all this information allows the user to double check and ensure they are backing up the right files.
	echo "###### $user ######"
	echo "Files to be included: $src_files"
	echo "Directories to be included: $src_directories"
	echo "Files archived: $arch_files"
	echo "Directories archived: $arch_directories"

	#Checks to see if the archive was completed correctly
	#Allowing the user to see that the backup completed or failed will ensure there are no "false positives". I.E. They think it actually backed up
	#when it actually failed.
	if [ $src_files -eq $arch_files ]; then 
		echo "Backup of $input completed!"
		echo "Details about the output backup file"
		ls -l $output
	else
		echo "Backup of $input failed"
	fi
}

#for loop which runs the code above
#I don't have anything to add to this one as the comment that Hunter made above basically covers it.
for directory in $*; do
	backup $directory
	let all=$all+$arch_files+$arch_directories
done;
	echo "TOTAL FILES AND DIRECTORIES: $all"
