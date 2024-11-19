# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: JFikents <Jfikents@student.42Heilbronn.de> +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/19 16:17:35 by JFikents          #+#    #+#              #
#    Updated: 2024/11/19 16:37:47 by JFikents         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

start: start_swarm
	docker-compose -f src/docker-compose.yml up
.PHONY: start

stop:
	docker-compose down
.PHONY: stop

start_swarm:
	@if ! docker info | grep -q "Swarm: active";\
	then\
		docker swarm init;\
	fi
.PHONY: start_swarm

