#!/bin/bash

#Path of the files.
#SCRIPT_PATH="/root/bin/backup-rsync.sh"
#DATABASE_PATH="/root/bin/mysql-rsync.sh"

#Error log path
ERROR_PATH=`pwd`/error.log

touch "${ERROR_PATH}"

echo "BOTH SCRIPTS ARE RUNNING ON ${HOSTNAME}" >> "${ERROR_PATH}"

HOSTNAME=$(hostname -s)

HOME_FOLDER="${HOME}"

SCRIPT_PATH="${HOME_FOLDER}/script.sh"
DATABASE_PATH="${HOME_FOLDER}/mysql.sh"


#Execute the files
if [[ -f "${SCRIPT_PATH}" ]]
then
    echo "Running the Script !!!" >> "${ERROR_PATH}"
    bash "${SCRIPT_PATH}" >> "${ERROR_PATH}"
    cat "${ERROR_PATH}"
else
    echo "SCRIPT files does not exist !!! " >> "${SCRIPT_PATH}"
fi

if [[ -f "${DATABASE_PATH}" ]]
then
    echo "Running the DATABASE Script !!!" >> "${ERROR_PATH}"
    bash "${DATABASE_PATH}" >> "${ERROR_PATH}"
    cat "${ERROR_PATH}"
else
    echo "DATABASE file does not exist"
fi

echo "BOTH SCRIPTS HAVE RAN SUCCESSFULLY ON ${HOSTNAME}" >> "${ERROR_PATH}"
echo "" >> "${ERROR_PATH}"
cat "${ERROR_PATH}"