#!/bin/sh

chown -R www-data:www-data /var/www/

sudo -u www-data sh -c "wp core download"
sudo -u www-data sh -c "wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$WORDPRESS_DB_HOST --dbcharset='utf8'"
sudo -u www-data sh -c "wp core install --url=$WORDPRESS_URL --title=Inception --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email"
sudo -u www-data sh -c "wp user create $WORDPRESS_GUEST_USER $WORDPRESS_GUEST_EMAIL --role=author --user_pass=$WORDPRESS_GUEST_PASSWORD"
sudo -u www-data sh -c "wp plugin update --all"

ln -s $(find /usr/sbin -name 'php-fpm*') /usr/bin/php-fpm

exec /usr/bin/php-fpm -F