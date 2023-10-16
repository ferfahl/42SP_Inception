#the image set is the penultime stable version of debian
FROM		debian:bullseye

ARG			MYSQL_DATABASE
ARG			MYSQL_ROOT
ARG			MYSQL_ROOT_PASSWORD
ARG			MYSQL_USER
ARG			MYSQL_PASSWORD

RUN			apt update

RUN			apt install mariadb-server mariadb-client procps -y

RUN			mkdir -p /var/lib/mysql /var/run/mysqld && \
			chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
			chmod 777 /var/run/mysqld

# Allow mysql to communicate with wordpress in the network
RUN			rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY		./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
RUN			chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

RUN			echo "\n[mariadb]\nbind-address=0.0.0.0\nport=3306\n" >>/etc/mysql/my.cnf

COPY		tools /tmp/

RUN			chmod a+x /tmp/setup.sh

RUN			/tmp/setup.sh

EXPOSE		3306

ENTRYPOINT	["mysqld_safe"]