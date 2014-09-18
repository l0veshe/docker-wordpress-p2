#!/bin/bash
FILE=backup-wp1p2-`date +%Y%m%d`.sql
mysqldump wp1 > /$FILE
gzip -f /$FILE
s3cmd put /$FILE.gz s3://gc1-backups/