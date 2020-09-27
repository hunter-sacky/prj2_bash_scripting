#!/bin/bash
#This bash script is used to backup a user's Desktop directory to the Documents directory
user=$(whoami)
input=/c/Users/$user/Desktop
output=/c/Users/$user/Documents/${user}_desktop_$(date +%Y-%m-%d_%H%M%S).tar

#Added the 2> to get rid of the stderr message.
tar -czf $output $input 2> null.txt
echo "Backup of $input completed! Details about the output backup file:"
ls -l $output
