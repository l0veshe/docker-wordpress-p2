#!/bin/sh

/usr/sbin/mysqld &
sleep 5
echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'mysql-server' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql
echo "GRANT ALL ON *.* TO admin@'localhost' IDENTIFIED BY 'mysql-server' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql


#
# Create empty DB for wordpress
#

DBNAME="wp0"
DBUSER="wp0"
DBPASSWORD="wp0"

echo "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; create user $DBUSER;" | mysql
echo "grant usage on *.* to '$DBUSER'@'%' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant usage on *.* to '$DBUSER'@'localhost' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant all privileges on $DBNAME.* to '$DBUSER'@'%'; FLUSH PRIVILEGES" | mysql


#
# Create Wordpress DB
#

DBNAME="wp1"
DBUSER="wp1"
DBPASSWORD="wp1"
SQLFILE="/src-mysql/wp1p2redirect.sql"

echo "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci; create user $DBUSER;" | mysql
echo "grant usage on *.* to '$DBUSER'@'%' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant usage on *.* to '$DBUSER'@'localhost' identified by '$DBPASSWORD'; FLUSH PRIVILEGES" | mysql
echo "grant all privileges on $DBNAME.* to '$DBUSER'@'%'; FLUSH PRIVILEGES" | mysql
gunzip $SQLFILE.gz
mysql -u$DBUSER -p$DBPASSWORD $DBNAME < $SQLFILE
