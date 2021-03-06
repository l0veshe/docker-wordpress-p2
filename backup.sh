#!/bin/bash
source /env
FILE=backup-wp1p2-`hostname`-`date +%Y%m%d`.sql
mysqldump wp1 > /$FILE
gzip -f /$FILE
/usr/bin/python /usr/local/bin/s3cmd -c /.s3cfg put /$FILE.gz s3://gc1-backups/