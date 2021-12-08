.PHONY: up down logs bash

up: #levantar el contenedor
	docker-compose up --build -d

down: #bajar el contenedor
	docker-compose down

logs: #Ver el log de docker
	docker-compose logs -f

bash: #Ingresar a la consola de un contenedor
	docker exec -it -u `id -u`:`id -g` dampp-php74 /bin/bash

cmd: #Ejecutar un comando dentro del contenedor
	docker-compose exec dampp-php74 bash

mysql-dump:
	docker exec dammp-mysql sh -c 'exec mysqldump --all-databases -uroot -p"root"' > ./all-databases.sql

uninstall: #docker rmi $(docker image ls -q)
	docker rmi `docker images -q`; docker network prune



#Eliminar todos los contenedores:  docker rm $(docker ps -a -q) 
