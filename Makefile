# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: JFikents <Jfikents@student.42Heilbronn.de> +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/19 16:17:35 by JFikents          #+#    #+#              #
#    Updated: 2024/11/23 19:15:40 by JFikents         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE=docker-compose -f src/docker-compose.yml

build:
	$(DOCKER_COMPOSE) up --build
.PHONY: build

start:
	$(DOCKER_COMPOSE) up
.PHONY: start

stop:
	$(DOCKER_COMPOSE) down
.PHONY: stop

clean:
	$(DOCKER_COMPOSE) down --volumes --remove-orphans
	$(DOCKER_COMPOSE) down --rmi all
	docker system prune -a --volumes -f
.PHONY: clean

re: clean start
.PHONY: re