#!/bin/bash

#Get the input from the file and ssh into the client machines and run the script
paste -d@ domain_name.txt password.txt | while IFS="@" read -r domain password
do
	#	echo "sshpass -p ""${password}"" ssh -o StrictHostKeyChecking=no root@"${domain}" ""bash -s"" < internal_file_copier.sh > ""${domain}"".pub"
		sshpass -p ""${password}"" ssh -o StrictHostKeyChecking=no root@"${domain}" "bash -s" < client_script_runner.sh >>\
		       	"stagethree.err"
					
	done