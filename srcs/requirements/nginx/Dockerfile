FROM		debian:buster

RUN			apt-get update && apt-get install -y \
			nginx \
			vim \
			openssl \
			procps \
			&& mkdir /etc/nginx/ssl \
			&& openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
			-out /etc/nginx/ssl/inception.crt \
			-keyout /etc/nginx/ssl/inception.key \
			-subj "/C=BR/ST=SaoPaulo/L=SaoPaulo/O=42SP/OU=feralves/CN=feralves.42.fr"

COPY		./conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN			mkdir -p /run/nginx

EXPOSE		443

CMD			["nginx", "-g", "daemon off;"]