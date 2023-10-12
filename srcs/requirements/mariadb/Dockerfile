#the image set is the penultime stable version of debian
FROM debian:bullseye

#The RUN instruction executes the commands
#in here we are installing mariadb server and client and vim
RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y mariadb-server \
    mariadb-client vim \
    && rm -rf /var/lib/apt/lists/*

# Allow mysqld daemon to run, purge and recreate /var/lib/mysql with appropriate ownership
# Ensure /var/run/mysqld is writable regardless of UID of mysqld at runtime
RUN mkdir -p /var/run/mysqld \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

# Expose port 3306 (default port for MariaDB)
EXPOSE 3306

# Copy shell script that sets up MariaDB database and user accounts
COPY ./tools/start_db.sh /usr/local/bin/
COPY ./conf/wordpress.sql /usr/local/bin/

# Set permissions for the script to be executable
RUN chmod +x /usr/local/bin/start_db.sh
RUN chmod +x /usr/local/bin/wordpress.sql

ENTRYPOINT [ "/usr/local/bin/start_db.sh" ]

#Command to launch mariadb and enable the database to listen globally - also can be put on mysqldump.cnf file
CMD ["mysqld", "--bind-address=0.0.0.0"]