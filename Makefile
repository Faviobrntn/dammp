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

# IMPORTAR DB MYSQL: docker exec -t <CONTENEDOR_MYSQL> mysql -u root -p"secret" nombre_db < archivo.sql
importar_db:
	docker exec -i dammp-mysql mysql -u root -p"root" db_name < db_name.sql

# EXPORTAR DB MYSQL: docker exec -t <CONTENEDOR_MYSQL> mysqldump -u root -p"" nombre_db > archivo.sql
exportar_db:
	docker exec -i dammp-mysql mysqldump -u root -p"root" db_name > db_name.sql



uninstall: #docker rmi $(docker image ls -q)
	docker rmi `docker images -q`; docker network prune; docker volume prune


# pass_traefik: #htpasswd -nb admin dammpadmin
# 	htpasswd -nb admin

#Eliminar todos los contenedores:  docker rm $(docker ps -a -q) 


install:
	docker run -d \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $PWD/config/traefik/traefik.toml:/traefik.toml \
		-v $PWD/config/traefik/acme.json:/acme.json \
		-p 80:80 \
		-p 443:443 \
		-l traefik.frontend.rule=Host:monitor.localhost \
		-l traefik.port=8080 \
		--network web \
		--name traefik \
		traefik:1.7.2-alpine