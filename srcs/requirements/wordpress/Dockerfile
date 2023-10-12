#the image set is the penultime stable version of debian
FROM debian:bullseye

ARG MYSQL_PASSWORD

RUN apt update -y && apt upgrade -y && apt install -y \
	php-fpm \
	php-mysql \
	mariadb-client -y \
	wget
RUN curl -O https://wordpress.org/latest.tar.gz
RUN tar xvf latest.tar.gz
RUN mkdir -p /var/www/html
RUN mv wordpress /var/www/html/
RUN chown -R www-data:www-data /var/www/html/wordpress
RUN chmod -R 0777 /var/www/html/wordpress/wp-content/
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY ./conf/wp-config.php /var/www/html/wordpress
RUN sed -i "s/password_here/$MYSQL_PASSWORD/g" /var/www/html/wordpress/wp-config.php
RUN mkdir /run/php
EXPOSE 9000
CMD ["php-fpm7.3", "--nodaemonize"]