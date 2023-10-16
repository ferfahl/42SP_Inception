#the image set is the penultime stable version of debian
FROM		debian:bullseye

#the args that are needed from the .env file
ARG			MYSQL_DATABASE
ARG			MYSQL_ROOT
ARG			MYSQL_ROOT_PASSWORD
ARG			MYSQL_USER
ARG			MYSQL_PASSWORD

#updates the package lists
RUN			apt update

#install mariadb and necessary for it to work
RUN			apt install mariadb-server mariadb-client procps -y

#allow mysqld daemon to run, purge and recreate /var/lib/mysql with appropriate ownership
RUN			mkdir -p /var/lib/mysql /var/run/mysqld && \
			chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
			chmod 777 /var/run/mysqld

# Allow mariadb to communicate with wordpress in the network
RUN			rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY		./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
RUN			chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

#sends the mariadb address to the configuration file
RUN			echo "\n[mariadb]\nbind-address=0.0.0.0\nport=3306\n" >>/etc/mysql/my.cnf

#copies the tools folder inside the container and changes it's permission
COPY		tools /tmp/
RUN			chmod a+x /tmp/setup.sh

#runs the script to setup the mariadb inside the container
RUN			/tmp/setup.sh

#exposes the 3306 port (default port for MariaDB)
EXPOSE		3306

#Sets the entrypoint for the docker
ENTRYPOINT	["mysqld_safe"]