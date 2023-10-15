FROM 		debian:bullseye

STOPSIGNAL SIGTERM

#1) INSTALL VIM, WGET AND PHP-FPM AND PHP-MYSQL;
RUN			apt-get update \
			&& apt-get install -y apt-utils vim wget \
			php7.4 \
			php7.4-fpm \
			php7.4-mysql \
			mariadb-client \
			wget \
			sudo \
			&& mkdir /run/php

#2) SET PHP-FPM TO LISTEM PACKED FROM NETWORK IN PORT 9000;
COPY		conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

#3) DOWNLOAD WP-CLI AND MOVE IT TO VOLUME
RUN			wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  \
			&& chmod +x wp-cli.phar \
			&& mv wp-cli.phar /usr/bin/wp

EXPOSE		9000

#4) SET THE CONTAINER INITIAL DIRECTORY
WORKDIR		/var/www/feralves/wordpress/

#5) EXECUTE THE SCRIPT TO FILL WP_CONFIG.PHP WITH DATABASE USERNAME, LOGIN, HOST, DATABASE ETC AND
#   EXECUTE PHP-FPM SERVICE IN NO DAEMON MODE, LOCKING TERMINAL, AVOIDING CONTAINER EXIT
COPY		conf/wp-config.php .
RUN			chmod 777 wp-config.php

COPY		tools/wp_install.sh .
RUN			chmod 777 wp_install.sh

ENTRYPOINT ["sh", "wp_install.sh"]