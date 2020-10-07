#!/bin/bash
#Переменные $1 $2 указываются в соответствующих заданиях crontab
backuppath=$1
checkdays=$2

if [ -z "$backuppath" ] || [ -z "$checkdays" ] ; then
        exit 1
fi

deletedays=$(($checkdays+1))

if [[ $(find "${backuppath}" -type f -mtime -"${checkdays}") ]]; then
        find "${backuppath}" -type f \( -name "*.zip" -o -name "*.gz" \) -mtime +${deletedays} -exec rm {} \;
else
    echo "no earlier backups found, exiting"
fi
