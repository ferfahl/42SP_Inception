#!/bin/bash

service mariadb start

# Kill the anonymous users
mariadb -e "DROP USER IF EXISTS ''@'localhost'"

# Kill off the demo database
mariadb -e "DROP DATABASE IF EXISTS test"

# Create Wordpress database
mariadb -e "CREATE DATABASE $MYSQL_DATABASE"

# Create Mariadb/Wordpress user
mariadb -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"

# Grant privileges to user
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%'"

# Make sure that NOBODY can access the server without a password
mariadb -e "ALTER USER '$MYSQL_ROOT'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';FLUSH PRIVILEGES"