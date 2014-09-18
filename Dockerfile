# MySQL Server with Apache and phpmyadmin
#
# VERSION               0.0.1

FROM     ubuntu:latest
MAINTAINER Jonas Colmsjö "jonas@gizur.com"



RUN apt-get update
RUN apt-get install -y nano git wget


# Install supervisord (used to handle processes)
# ----------------------------------------------
#
# Installation with easy_install is more reliable. apt-get don't always work.

RUN apt-get install -y python python-setuptools
RUN easy_install supervisor

ADD ./etc-supervisord.conf /etc/supervisord.conf
ADD ./etc-supervisor-conf.d-supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisor/


#
# Install Apache and PHP
# ----------------------

RUN apt-get install -y apache2 php5 php5-curl php5-mysql php5-mcrypt
RUN a2enmod rewrite status

ADD ./etc-apache2-apache2.conf /etc/apache2/apache2.conf
ADD ./etc-apache2-mods-available-status.conf /etc/apache2/mods-available/status.conf

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

ADD ./src-wordpress /var/www/html/


#
# Install MySQL
# -------------

# Install scripts
ADD ./src-mysql /src-mysql


# Install MySQL server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && apt-get clean && rm -rf /var/lib/apt/lists/*

# Fix configuration
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Setup admin user and load data
RUN /src-mysql/mysql-setup.sh


#
# Start things up
# ------------------

ADD ./start.sh /

EXPOSE 80 443
CMD ["/start.sh"]

