#!/bin/bash

#Get the input from the file.
paste -d@ domain_name.txt password.txt | while IFS="@" read -r domain password
do
	#	echo "sshpass -p ""${password}"" ssh -o StrictHostKeyChecking=no root@"${domain}" ""bash -s"" < internal_file_copier.sh > ""${domain}"".pub"
		sshpass -p ""${password}"" ssh -o StrictHostKeyChecking=no root@"${domain}" "bash -s" < internal_file_copier.sh >\
		       	"${domain}.pub"
					
	done
