#!/bin/sh

#1) 
WP_CONFIG="wp-config.php"
mv wp-config-sample.php wp-config.php

#2) INSIDE WP-CONFIG.PHP FILL THE DATABASE INFORMATIONS THAT WORDPRESS NEEDS TO COMMUNICATE WITH MARIADB
sed -i "s/username_here/$MYSQL_USER/g"                                      $WP_CONFIG
sed -i "s/password_here/$MYSQL_PASSWORD/g"                                  $WP_CONFIG
sed -i "s/localhost/$WP_HOSTNAME/g"                                         $WP_CONFIG
sed -i "s/database_name_here/$MYSQL_DATABASE/g"                             $WP_CONFIG
sed -i "s/define( 'WP_DEBUG', false );/define( 'WP_DEBUG', true );/g"       $WP_CONFIG