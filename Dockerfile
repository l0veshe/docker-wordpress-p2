# MySQL Server with Apache and phpmyadmin
#
# VERSION               0.0.1

FROM     ubuntu:14.10
MAINTAINER Jonas Colmsjö "jonas@gizur.com"



RUN apt-get update
RUN apt-get install -y nano git wget unzip cron



# Install supervisord (used to handle processes)
# ----------------------------------------------
#
# Installation with easy_install is more reliable. apt-get don't always work.

RUN apt-get install -y python python-setuptools python-magic 
RUN easy_install supervisor 
RUN easy_install pip

ADD ./etc-supervisord.conf /etc/supervisord.conf
ADD ./etc-supervisor-conf.d-supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor/


#
# Setup S3
# ---------

RUN wget https://github.com/s3tools/s3cmd/archive/master.zip
RUN unzip /master.zip
RUN cd /s3cmd-master; python setup.py install
RUN apt-get install -y python-dateutil

ADD ./s3cfg /.s3cfg


#
# Install cron
# ------------

# Run jon every minute
RUN echo '*/1 * * * *  /bin/bash -c "/backup.sh"' > /mycron
RUN crontab /mycron

ADD ./etc-pam.d-cron /etc/pam.d/cron


#
# Install rsyslog
# ---------------

RUN apt-get install -y rsyslog

ADD ./etc-rsyslog.conf /etc/rsyslog.conf
ADD ./etc-rsyslog.d-50-default.conf /etc/rsyslog.d/50-default.conf


#
# Install MySQL
# -------------


# Install MySQL server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

# Fix configuration
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Setup admin user and load data
ADD ./src-mysql/ /src-mysql/
RUN /src-mysql/mysql-setup.sh


#
# Install Apache and PHP
# ----------------------

RUN apt-get update
#RUN apt-get install -y apache2 php5 php5-curl php5-mysql php5-mcrypt
RUN apt-get install -y apache2 php5 php5-curl php5-mysql
RUN a2enmod rewrite status

ADD ./etc-apache2-apache2.conf /etc/apache2/apache2.conf
ADD ./etc-apache2-mods-available-status.conf /etc/apache2/mods-available/status.conf

RUN chown www-data:www-data -R /var/www/

RUN rm /var/www/html/index.html
RUN echo "<?php\nphpinfo();\n " > /var/www/html/info.php


#
# Install phpMyAdmin
# -------------------

ADD ./src-phpmyadmin/phpMyAdmin-4.0.8-all-languages.tar.gz /var/www/html/
ADD ./src-phpmyadmin/config.inc.php /var/www/html/phpMyAdmin-4.0.8-all-languages/config.inc.php


#
# Install Wordpress
# -----------------

ADD ./wordpress-4.0.tar.gz /
RUN cp -r /wordpress/* /var/www/html/
ADD ./src-wp/wp-config.php /var/www/html/
ADD ./src-wp/p2.tgz /var/www/html/wp-content/themes

# Make login mandatory
ADD ./src-wp/peters-login-redirect.tgz /var/www/html/wp-content/plugins

# Make site private
ADD ./src-wp/add-to-functions.php /
RUN cat /add-to-functions.php >> /var/www/html/wp-content/themes/p2/functions.php

# Remove toolbar
ADD ./src-wp/toolbar-removal-completely-disable.tgz /var/www/html/wp-content/plugins

RUN mkdir -p /var/www/html/wp-content/uploads
RUN chmod +w /var/www/html/wp-content/uploads

#
# Cleanup and start things up
# --------------------------

#RUN apt-get clean; rm -rf /var/lib/apt/lists/*

ADD ./batches.py /
ADD ./backup.sh /
ADD ./start.sh /

EXPOSE 80 443
CMD ["/start.sh"]

