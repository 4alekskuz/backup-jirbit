#!/bin/sh
sudo -u postgres pg_dumpall | gzip > /var/backups/atlassian-base/all_dbs_`date +%Y-%m-%d.%H.%M`.sql.gz
