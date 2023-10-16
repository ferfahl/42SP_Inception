#the image set is the penultime stable version of debian
FROM	debian:bullseye

#the args that are needed from the .env file
ARG		DOMAIN_NAME
ARG		CERTS_CRT
ARG		CERTS_KEY

#updates the package lists
RUN		apt-get update && apt-get upgrade -y

#installing nginx and openssl
RUN		apt-get install -y nginx \
		openssl gettext-base && \
		rm -rf /var/lib/apt/lists/*

#make nginx SSL to be able to run
RUN		mkdir /etc/nginx/ssl
RUN		openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
		-out $CERTS_CRT -keyout $CERTS_KEY \
		-subj "/C=42/ST=SP/L=SP/O=Global Security/OU=Inception/CN=$DOMAIN_NAME"

#the only port availabe according to the subject
EXPOSE	443

#copies the Nginx configuration file to the /etc/nginx/conf.d/nginx.conf
COPY	./conf/default.template ./etc/nginx/conf.d/nginx.conf

#changes the enviroment arguments to whatever is on the .env
RUN 	sed -i "s#CERTS_KEY#$CERTS_KEY#" /etc/nginx/conf.d/nginx.conf && \
		sed -i "s#CERTS_CRT#$CERTS_CRT#" /etc/nginx/conf.d/nginx.conf && \
		sed -i "s#DOMAIN_NAME#$DOMAIN_NAME#" /etc/nginx/conf.d/nginx.conf

#nginx config folder
RUN		mkdir -p /run/nginx

#The CMD instruction specifies the default command to run when the container is started
CMD		["nginx", "-g", "daemon off;"]