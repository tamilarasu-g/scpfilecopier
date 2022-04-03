#!/bin/bash

SSH_PORT="22"

#Get the input from the file.
paste -d@ domain_name.txt password.txt | while IFS="@" read -r domain password
do
	#	echo "sshpass -p ""${password}"" ssh -o StrictHostKeyChecking=no root@"${domain}" ""bash -s"" < internal_file_copier.sh > ""${domain}"".pub"
		sshpass -p ""${password}"" ssh -o StrictHostKeyChecking=no root@"${domain}" "bash -s" < internal_file_copier.sh >\
		       	"${domain}.pub"
		#sshpass -p ""${password}"" ssh -p "${SSH_PORT}" -o StrictHostKeyChecking=no root@"${domain}" "bash -s" < internal_file_copier.sh >\
				"${domain}.pub"		
	done

#Check if any empty files exist..
PWD=$(pwd)

find `${pwd}` -empty -type f -delete

#Move all the .pub files to the desired folder

HOME_FOLDER=$HOME

DESTINATION_FOLDER="$HOME_FOLDER"/pubfiles/

echo "Moving the files to the desired folder"
mv *.pub "${DESTINATION_FOLDER}"
echo "Successfully moved the files !!!"
