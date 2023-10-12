#the image set is the penultime stable version of debian
FROM debian:bullseye

#The RUN instruction executes the commands
#in here we are installing nginx and openssl
RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx openssl && \
	rm -rf /var/lib/apt/lists/*

#now we make nginx SSL to be able to run
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
       -subj "/C=42/ST=SP/L=SP/O=Global Security/OU=Inception/CN=feralves.42.fr"

#the only port availabe according to the subject
EXPOSE 443

#copies the Nginx configuration file nginx.conf to the /etc/nginx/conf.d/
COPY ./conf/nginx.conf ./etc/nginx/conf.d/

# nginx config
RUN mkdir -p /run/nginx

#The CMD instruction specifies the default command to run when the container is started
CMD ["nginx", "-g", "daemon off;"]