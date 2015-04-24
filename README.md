Wordpress P2 discussion
=======================

Build the container: `docker build --rm -t p2 .`

The MySQL backups are stored in S3 and therefore requires S3 credentials.

Run in interactive mode:  
`docker run -t -i --name p2 --restart="on-failure:10"  \
-e S3_ACCESS_KEY=... -e S3_SECRET_KEY=... p2 /bin/bash`

run `start.sh` to start the processes (managed by supervisor).

detach from the container with `ctrl-p` `ctrl-q` and it will continue to run
(exit will stop the container).

The database dump is configured with a URL that needs to be changed.
Open phpMyAdmin and update it in wp1.wp_options - http://[IP]:[PORT]/phpMyAdmin-4.0.8-all-languages


Using
-----

All users needs to be auhtors to publish their own content, more details [here](http://codex.wordpress.org/Roles_and_Capabilities)


Credentials
-----------

MySQL:

 * admin / mysql-server - superuser, IMPORTANT: Make sure to change the password
 * wp1 / wp1 - WordPress database
 * wp2 / wp2 - empty database


Worpress:

 * admin / h+4D+Be5ZAHuxc8L8/4c2XKPBR7T9i4gvYRNIuENSYQ=


Troubleshooting
---------------

 * A trick was needed to make wordpress work behind a reverse proxy doing SSL
   terminal. I found the solution
   [here](http://serverascode.com/2014/05/31/wordpress-ssl-reverse-proxy.html)

 * Problem with infinite redirect (302) loop. Move the p2 theme folder out of
   `wp-content/themes`. Login a admin and check the settings page (or update using
   phpMyAdmin).

 * Try the [WP cli tool](http://wp-cli.org/) in case of problems you can't solve

 * Change any option: http://[IP]/wp-admin/options.php
  *  http://codex.wordpress.org/Option_Reference
