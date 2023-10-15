#!/bin/bash

mysqld_safe &
service mysql start

# Kill the anonymous users
mysql -e "DROP USER IF EXISTS ''@'localhost'"

# Kill off the demo database
mysql -e "DROP DATABASE IF EXISTS test"

# Create Wordpress database
mysql -e "CREATE DATABASE $MYSQL_DATABASE"

# Create Mariadb/Wordpress user
mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"

# Grant privileges to user
mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%'"

# Make sure that NOBODY can access the server without a password
mysql -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';FLUSH PRIVILEGES"