#!/bin/bash

#Set the default port
DEFAULT_PORT="22"

#Get the port number as an argument
if [[ ! -z "${1}" ]]
then
    DEFAULT_PORT="${1}"
fi

#Get the input from the file and ssh into the client machines and run the script
paste -d@ domain_name.txt password.txt | while IFS="@" read -r domain password
do
	#	echo "sshpass -p ""${password}"" ssh -o StrictHostKeyChecking=no root@"${domain}" ""bash -s"" < internal_file_copier.sh > ""${domain}"".pub"
		sshpass -p ""${password}"" ssh -p "${DEFAULT_PORT}" -o StrictHostKeyChecking=no root@"${domain}" "bash -s" < support02.sh >>\
		       	"stagetwo.err"
					
	done