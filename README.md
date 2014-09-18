Wordpress P2 discussion
=======================

Build the container: `docker build --rm -t p2 .`


The MySQL backups are stored in S3 and therefore requires S3 credentials.

Run with: `docker run -d --name p2 -p 80:80 -e S3_ACCESS_KEY=... -e S3_SECRET_KEY=... p2`

Run in interactive mode:  `docker run -t -i --name p2 -p 80:80 --rm -e S3_ACCESS_KEY=... -e S3_SECRET_KEY=... p2 /bin/bash`


Using
-----

All users needs to be auhtors to publish their own content, more details [here](http://codex.wordpress.org/Roles_and_Capabilities)


Credentials
-----------

MySQL:

 * admin / mysql-server
 * wp1 / wp1
 * wp2 / wp2


Worpress:

 * admin / h+4D+Be5ZAHuxc8L8/4c2XKPBR7T9i4gvYRNIuENSYQ=


Troubleshooting
---------------


 * Change any option: http://[IP]/wp-admin/options.php
  *  http://codex.wordpress.org/Option_Reference

