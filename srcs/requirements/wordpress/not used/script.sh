#!/bin/sh

if ! wp core is-installed --allow-root --path=/var/www/wordpress; then

	wp core install --allow-root --path=/var/www/wordpress --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL

	wp user create --allow-root --path=/var/www/wordpress $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PWD

	wp plugin uninstall --allow-root --path=/var/www/wordpress akismet hello

	wp option update --allow-root --path=/var/www/wordpress blogdescription "$WP_SUB_TITLE"

	wp plugin update --all --allow-root --path=/var/www/wordpress

	chown -R www-data:www-data /var/www/wordpress

	chmod -R 774 /var/www/wordpress

else

	yes | cp -r /var/lib/wordpress/* /var/www/wordpress

fi

php-fpm7.3 -F