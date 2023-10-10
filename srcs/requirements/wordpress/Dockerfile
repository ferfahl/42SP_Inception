FROM		debian:buster

RUN			apt-get update && apt-get -y install \
			wget \
			apt-utils \
			vim \
			php7.3 \
			php7.3-fpm \
			php7.3-opcache \
			php7.3-cli \
			php7.3-gd \
			php7.3-curl \
			php7.3-mysql \
			php7.3-mbstring

RUN			mkdir /run/php && \
			mkdir -p /var/www/feralves && \
			wget https://wordpress.org/latest.tar.gz && \
			tar -xzvf latest.tar.gz && \
			rm latest.tar.gz && \
			mv wordpress /var/www/feralves/wordpress

COPY		conf/ /srcs/
COPY		tools/ /usr/local/bin/

RUN			chmod +x /usr/local/bin/start_wordpress.sh

RUN			cp /srcs/www.conf /etc/php/7.3/fpm/pool.d/

WORKDIR		/var/www/feralves/wordpress

ENTRYPOINT	["/usr/local/bin/start_wordpress.sh"]

EXPOSE		9000

CMD			["/usr/sbin/php-fpm7.3", "--nodaemonize"]