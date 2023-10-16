# 42SP_Inception
System Administration related exercise. v1.3

This project is meant to run in the Xubuntu version of the VM from 42.
In a clean machine install, please run first <TT>make update-env</TT> so it works properly.

The <TT>.env</TT> file should be configured as:
```
DOMAIN_NAME=xxxxxx.42.fr
CERTS_CRT=xxxxxxxxxxxxxxxxxxxxxxxx
CERTS_KEY=xxxxxxxxxxxxxxxxxxxxxxxx

#Data for Mariadb
MYSQL_DATABASE=xxxxxx
MYSQL_ROOT=xxxxxx
MYSQL_ROOT_PASSWORD=xxxxxx
MYSQL_USER=xxxxxx
MYSQL_PASSWORD=xxxxxx

#Data for Wordpress
WORDPRESS_DB_HOST=xxxxxx #should be mariadb
WORDPRESS_DB_NAME=xxxxxx
WORDPRESS_URL=xxxxxx.42.fr
WORDPRESS_GUEST_USER=xxxxxx
WORDPRESS_GUEST_PASSWORD=xxxxxx
WORDPRESS_DB_USER=xxxxxx
WORDPRESS_DB_PASSWORD=xxxxxx
WORDPRESS_ADMIN_USER=xxxxxx
WORDPRESS_ADMIN_PASSWORD=xxxxxx
WORDPRESS_ADMIN_EMAIL=xxxxxx
```