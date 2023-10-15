FROM 		debian:bullseye

STOPSIGNAL SIGTERM

#1) INSTALL VIM, WGET AND PHP-FPM AND PHP-MYSQL;
RUN			apt-get update \
			&& apt-get install -y apt-utils vim wget \
			php7.4 \
			php7.4-fpm \
			php7.4-mysql \
			&& mkdir /run/php

#2) SET PHP-FPM TO LISTEM PACKED FROM NETWORK IN PORT 9000;
COPY		conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

#3) DOWNLOAD WORDPRESS AND MOVE IT TO VOLUME
RUN			chmod 777 /etc/php/7.4/fpm/pool.d/www.conf \
			&& mkdir -p /var/www/feralves \
			&& wget https://wordpress.org/latest.tar.gz \
			&& tar xzvf latest.tar.gz \
			&& mv -f wordpress /var/www/feralves

EXPOSE		9000

#4) SET THE CONTAINER INITIAL DIRECTORY
WORKDIR		/var/www/feralves/wordpress/

#5) EXECUTE THE SCRIPT TO FILL WP_CONFIG.PHP WITH DATABASE USERNAME, LOGIN, HOST, DATABASE ETC AND
#   EXECUTE PHP-FPM SERVICE IN NO DAEMON MODE, LOCKING TERMINAL, AVOIDING CONTAINER EXIT
COPY		tools/init_wordpress.sh /
RUN			chmod 777 /init_wordpress.sh
ENTRYPOINT sh /init_wordpress.sh && /usr/sbin/php-fpm7.4 --nodaemonize