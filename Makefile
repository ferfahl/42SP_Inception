LOGIN			= feralves
COMPOSE			= srcs/docker-compose.yml
VOLUMES_PATH	= /home/$(LOGIN)/data
DOMAIN			= 127.0.0.1       $(LOGIN).42.fr
LOOKDOMAIN		= $(shell grep "${DOMAIN}" /etc/hosts)

export VOLUMES_PATH # Make it available for the Dockerfiles

all: srcs/.env hosts build up

list:
	docker ps -a

list-networks:
	docker network ls

list-volumes:
	docker volume ls

up:
	docker compose --file=$(COMPOSE) up --build --detach

build:
	sudo mkdir -p $(VOLUMES_PATH)/wordpress
	sudo mkdir -p $(VOLUMES_PATH)/mariadb

hosts:
	@if [ "${DOMAIN}" = "${LOOKDOMAIN}" ]; then \
		echo "Host already set"; \
	else \
		cp /etc/hosts ./hosts_bkp; \
		sudo rm /etc/hosts; \
		sudo cp ./srcs/requirements/tools/hosts /etc/hosts; \
	fi

srcs/.env:
	@echo "Missing .env file in srcs folder" && exit 1

down:
	docker compose --file=$(COMPOSE) down -v --rmi all --remove-orphans

config:
	docker compose --file=$(COMPOSE) config

fprune:
	docker system prune --all --force --volumes

fclean: down
	sudo mv ./hosts_bkp /etc/hosts || echo "hosts_bkp does not exist"
	sudo rm -rf /home/$(LOGIN)/data

re: fclean all