#the image set is the penultime stable version of debian
FROM	debian:bullseye

#the args that are needed from the .env file
ARG		DOMAIN_NAME
ARG		CERTS_CRT
ARG		CERTS_KEY

#installing nginx and openssl
RUN		apt-get update && apt-get upgrade -y && apt-get install -y nginx \
		openssl gettext-base && \
		rm -rf /var/lib/apt/lists/*

#make nginx SSL to be able to run
RUN		mkdir /etc/nginx/ssl
RUN		openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
		-out $CERTS_CRT -keyout $CERTS_KEY \
		-subj "/C=42/ST=SP/L=SP/O=Global Security/OU=Inception/CN=feralves.42.fr"

#the only port availabe according to the subject
EXPOSE	443

#copies the Nginx configuration file nginx.conf to the /etc/nginx/conf.d/
COPY	./conf/default.template ./etc/nginx/conf.d/

#changes the enviroment arguments to whatever is on the .env
RUN		envsubst < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/nginx.conf

#nginx config folder
RUN		mkdir -p /run/nginx

#The CMD instruction specifies the default command to run when the container is started
CMD		["nginx", "-g", "daemon off;"]