#the image set is the penultime stable version of debian
FROM debian:bullseye

# FROM debian:buster

# RUN apt-get update && apt-get -y install \
# 	wget \
# 	apt-utils \
# 	vim \
# 	php7.3 \
# 	php7.3-fpm \
# 	php7.3-opcache \
# 	php7.3-cli \
# 	php7.3-gd \
# 	php7.3-curl \
# 	php7.3-mysql \
# 	php7.3-mbstring

# RUN mkdir /run/php && \
# 	mkdir -p /var/www/feralves && \
# 	wget https://wordpress.org/latest.tar.gz && \
# 	tar -xzvf latest.tar.gz && \
# 	rm latest.tar.gz && \
# 	mv wordpress /var/www/feralves/wordpress

# COPY conf/ /srcs/
# COPY tools/ /usr/local/bin/

# RUN chmod +x /usr/local/bin/start_wordpress.sh

# RUN cp /srcs/www.conf /etc/php/7.3/fpm/pool.d/

# WORKDIR /var/www/feralves/wordpress

# ENTRYPOINT ["/usr/local/bin/start_wordpress.sh"]

# EXPOSE 9000

# CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]

WORKDIR /var/www/html/

RUN apt update -y && apt upgrade && apt install -y \
	php-fpm \
	php-mysql \
	mariadb-client \
	wget \
	sudo

RUN sed -i.default "/^listen\s=.*/c\listen = 0.0.0.0:9000" \
	/etc/php/[0-9]*.[0-9]*/fpm/pool.d/www.conf

COPY ./tools/wp_install.sh /tmp/wp_install.sh

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/bin/wp

WORKDIR	/var/www/html/wordpress

RUN	mkdir -p /run/php

CMD ["sh", "/tmp/wp_install.sh"]

# ARG MYSQL_PASSWORD

# RUN apt update -y && apt upgrade -y && apt install -y curl \
# 	php-fpm \
# 	php-mysql \
# 	mariadb-client -y \
# 	wget
# RUN curl -O https://wordpress.org/latest.tar.gz
# RUN tar xvf latest.tar.gz
# RUN mkdir -p /var/www/html
# RUN mv wordpress /var/www/html/
# RUN chown -R www-data:www-data /var/www/html/wordpress
# RUN chmod -R 0777 /var/www/html/wordpress/wp-content/
# COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d/
# COPY ./tools/wp-config.php /var/www/html/wordpress
# RUN sed -i "s/password_here/$MYSQL_PASSWORD/g" /var/www/html/wordpress/wp-config.php
# RUN mkdir /run/php
# EXPOSE 9000
# CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]