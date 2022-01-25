.PHONY: up down logs bash

up: #levantar el contenedor
	docker-compose up --build -d

down: #bajar el contenedor
	docker-compose down

logs: #Ver el log de docker
	docker-compose logs -f

bash: #Ingresar a la consola de un contenedor
	docker exec -it -u `id -u`:`id -g` dammp-php74 /bin/bash

cmd: #Ejecutar un comando dentro del contenedor
	docker-compose exec dammp-php74 bash

mysql-dump:
	docker exec dammp-mysql sh -c 'exec mysqldump --all-databases -uroot -p"root"' > ./all-databases.sql

uninstall: #docker rmi $(docker image ls -q)
	docker rmi `docker images -q`; docker network prune



#Eliminar todos los contenedores:  docker rm $(docker ps -a -q) 


# install:
# 	docker run -d \
# 		-v /var/run/docker.sock:/var/run/docker.sock \
# 		-v $PWD/config/traefik/traefik.toml:/traefik.toml \
# 		-v $PWD/config/traefik/acme.json:/acme.json \
# 		-p 80:80 \
# 		-p 443:443 \
# 		-l traefik.frontend.rule=Host:monitor.localhost \
# 		-l traefik.port=8080 \
# 		--network web \
# 		--name traefik \
# 		traefik:1.7.2-alpine