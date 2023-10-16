#the image set is the penultime stable version of debian
FROM 		debian:bullseye

#the args that are needed from the .env file
ARG			WORDPRESS_DB_HOST
ARG			WORDPRESS_DB_NAME
ARG			WORDPRESS_URL
ARG			WORDPRESS_GUEST_USER
ARG			WORDPRESS_GUEST_PASSWORD
ARG			WORDPRESS_DB_USER
ARG			WORDPRESS_DB_PASSWORD
ARG			WORDPRESS_ADMIN_USER
ARG			WORDPRESS_ADMIN_PASSWORD
ARG			WORDPRESS_ADMIN_EMAIL

#updates the package lists
RUN			apt-get update

#install all the needed programs for the wordpress to work (specially php and mariadb-client)
RUN			apt-get install -y apt-utils vim wget \
			php7.4 \
			php7.4-fpm \
			php7.4-mysql \
			mariadb-client \
			wget \
			sudo \
			&& mkdir /run/php

#set php-fm to listen through port 9000
COPY		conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

#download wp-cli and moves it to a folder inside the container
RUN			wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  \
			&& chmod +x wp-cli.phar \
			&& mv wp-cli.phar /usr/bin/wp

#exposes port 9000, which is the default port used by PHP-FPM
EXPOSE		9000

#set the container initial directory
WORKDIR		/var/www/html/wordpress

#Copies the script for the installation of wordpress
COPY		tools/wp_install.sh .
RUN			chmod 777 wp_install.sh

#Sets the entrypoint for the container to the wp_install.sh script
ENTRYPOINT ["sh", "wp_install.sh"]