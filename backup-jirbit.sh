#!/bin/bash
#daily backup script
#(c) Alex Kuznetsov 2020

#Поместить скрипт в PATH, например, в /usr/local/bin/
#Итого свободного места для выполнения резервного копирования  ~ 6 Gb

HOSTNAME="JIRBIT"

SUDO="/usr/bin/sudo"
PG_DUMP="/usr/bin/pg_dump"
GZIP="/bin/gzip"
TAR="/bin/tar"

HOMEDIR="/var/atlassian/application-data"
#INSTDIR="/opt/atlassian"
BACKUP_DIR="/home/ruslan/backup"
BACKUP_DATE=$(date +%Y-%m-%d)
BACKUP_FILE_FULL="$HOSTNAME"-backup-"$BACKUP_DATE".tar
BACKUP_FILE_HOME="$HOSTNAME"-atlassian-home-"$BACKUP_DATE".tar.gz
#BACKUP_FILE_INST="$HOSTNAME"-atlassian-inst-"$BACKUP_DATE".tar.gz
BACKUP_AGE=3

DB_BITB=bitbucketdb
DB_CONF=confluencedb
DB_JIRA=jiradb

BACKUP_BITB=$BACKUP_DIR/$BACKUP_DATE/$DB_BITB-$BACKUP_DATE

BACKUP_CONF=$BACKUP_DIR/$BACKUP_DATE/$DB_CONF-$BACKUP_DATE

BACKUP_JIRA=$BACKUP_DIR/$BACKUP_DATE/$DB_JIRA-$BACKUP_DATE

mkdir -p $BACKUP_DIR/$BACKUP_DATE

$SUDO tar -cPzf $BACKUP_DIR/$BACKUP_DATE/$BACKUP_FILE_HOME $HOMEDIR

#$SUDO tar -cPzf $BACKUP_DIR/$BACKUP_FILE_INST $INSTDIR

$SUDO -u postgres pg_dump $DB_BITB > $BACKUP_BITB.dump

$SUDO -u postgres pg_dump $DB_CONF > $BACKUP_CONF.dump

$SUDO -u postgres pg_dump $DB_JIRA > $BACKUP_JIRA.dump

tar -cPf $BACKUP_DIR/$BACKUP_FILE_FULL $BACKUP_DIR/$BACKUP_DATE

rm -r $BACKUP_DIR/$BACKUP_DATE

find $BACKUP_DIR/*.tar -mtime +$BACKUP_AGE -type f -delete
