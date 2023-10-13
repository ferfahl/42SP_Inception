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
	sudo mkdir -p $(VOLUMES_PATH)/mysql
	docker volume create --name mariadb_volume --opt type=none --opt device=$(VOLUMES_PATH)/mysql --opt o=bind
	sudo mkdir -p $(VOLUMES_PATH)/wordpress
	docker volume create --name wordpress_volume --opt type=none --opt device=$(VOLUMES_PATH)/wordpress --opt o=bind

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


fclean: down
	sudo rm -rf $(VOLUMES_PATH)/wordpress
	sudo rm -rf $(VOLUMES_PATH)/mariadb
	docker system prune --all --force --volumes
	# sudo mv ./hosts_bkp /etc/hosts || echo "hosts_bkp does not exist"

re: fclean all