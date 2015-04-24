<?php

/*
   Jonas C. - this is needed when running wordpress behind a reverse proxy,
   see http://serverascode.com/2014/05/31/wordpress-ssl-reverse-proxy.html
*/

define('FORCE_SSL_ADMIN', true);
if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')
			$_SERVER['HTTPS']='on';


/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wp1');

/** MySQL database username */
define('DB_USER', 'wp1');

/** MySQL database password */
define('DB_PASSWORD', 'wp1');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'w$o/&h`(F()RjPphElsoEdNRs,O*!o,G1FYq~c]^br|1L^}YJe(|[p|4TfFd/sO&');
define('SECURE_AUTH_KEY',  'h-4{_m0v(wx&0CoZfy8ULrPT%8-i=e)an`tQV@i(@6Y|-{-x )S-u$@7{}hm>Wwh');
define('LOGGED_IN_KEY',    '4)j)V!k^Z-ja~M9*qtnz~=.oI (R~P+r4So+m79V+:0;S6k_to-nSQUx#93xEREB');
define('NONCE_KEY',        'GctP*302lX,.N}r^TEKg+Tsy8G92q;L/wx!_cCwxJ<J|Xf<{fk#X+ |85f1u[A>c');
define('AUTH_SALT',        'b(YSdnz{//B4|A//0]`4)`hz#i+kP=%NlL4:IQi#7p?~#?Gi+2z5m51)X#~><ej!');
define('SECURE_AUTH_SALT', '&.Y04, jl)f6)^;gLuY)4>.I,$.tE8il /bLL!1k8H+}GTl]Pm=]!s0A2zVZ98U`');
define('LOGGED_IN_SALT',   '|Q=8$W]V:d: scO2pX2?G-?$P|,F@3j/ eLMj748fJ1|jVoBH|qE/!s~Mmt%5k9[');
define('NONCE_SALT',       'HYWnh4x]Um#KFpDNgJT~D]j|R)X;q?9 J|`O|)0otP_t=E &e/-<N|A>[+ nz6PS');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
