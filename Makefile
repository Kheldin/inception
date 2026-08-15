NAME = inception

COMPOSE = docker compose -f srcs/docker-compose.yml

DATA_DIR = /home/kacherch/data

all: up

up:
	@mkdir -p $(DATA_DIR)/mariadb
	@mkdir -p $(DATA_DIR)/wordpress
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v

fclean: clean
	@sudo rm -rf $(DATA_DIR)/mariadb
	@sudo rm -rf $(DATA_DIR)/wordpress
	@docker system prune -af --volumes

re: fclean all

.PHONY: all up down clean fclean re
