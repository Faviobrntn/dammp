# Docker Apache MultiPHP

Esta es una opción para desarrolladores que tienen varios proyectos PHP en distintas versiones. Le facilita tener todo en un solo lugar y a la vez poder probar un mismo proyecto en varias versiones.
Docker debe estar instalado y corriendo en el Sistema Operativo.

## Contenido:
- MySQL 5.7
- PHPMyAdmin
- Versiones de PHP configuradas: 
    - php 5.6
    - php 7.0
    - php 7.2
    - php 7.4

## Requisitos
- Tener instalado Docker.
- Tener la extension `docker-compose` instalada.

En caso de no tener Docker instalado, te dejo algunas guías para Sistemas operativos donde lo he probado:

**Instalar docker en Manjaro:** 
- Seguir los pasos de esta [WEB](https://manjaro.site/how-to-install-docker-on-manjaro-18-0/)

**Instalar docker en Ubuntu:** 
- [Documentación docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
- [Tutorial digitalocean](https://www.digitalocean.com/community/tutorials/como-instalar-y-usar-docker-en-ubuntu-18-04-1-es)

**Instalar docker en Windows:**
- [A través de docker desktop](https://www.docker.com/products/docker-desktop)

**Docker Desktop:**
Compatible con Windows / Linux / Mac
https://www.docker.com/products/docker-desktop

## Manual

Se clonan o descargan el zip del repo y lo ubican donde deseen (sugiero un lugar donde tengan espacio si es que van a manejar varios proyectos).

Estando dentro de la carpeta del proyecto, se pueden visualizar las siguiente carpetas:
- **config** - No tocar, va alojada configuración necesaria
- **htdocs** - Aquí vamos a ir poniendo nuestros proyectos PHP.
- **volumenes** - No tocar, esta carpeta permite que los datos de su DB persistan.

Dentro de la carpeta raíz, va a usar el siguiente comando:
`docker-compose up --build -d`, este comando se encarga de descargar las imágenes y crear los contenedores.

Si todo salio bien, ya podrá poner sus proyectos/scripts PHP dentro de la carpeta htdocs y visualizarlos en el navegador.

## Links
- PhpMyAdmin en http://localhost:8001/ (Usuario: root | Contraseña: root)
- Apache con PHP 5.6 en http://localhost:8056/
- Apache con PHP 7.0 en http://localhost:8070/
- Apache con PHP 7.2 en http://localhost:8072/
- Apache con PHP 7.4 en http://localhost:8074/

Dependiendo de la ruta de apache a la que entre, podrá ver como el proyecto esta funcionando en esa version, tenga en cuenta que si usa frameworks o librerías que tienen una version de php alta es posible que no se vea correctamente en versiones anteriores o salten warning/notice/etc..

**Ejemplo de acceso a proyecto:** 
Tengo un proyecto que se llama "prueba" que esta en la version 7.0 de PHP
- Copio ese proyecto y lo pego dentro de /htdocs/
- Voy a la URL http://localhost:8070/prueba


## Comandos útiles
- Ver listado de contenedores `docker ps -a`
- Entrar a la consola de un contenedor: `docker exec -it <NOMBRE_CONTENEDOR> /bin/bash`.  
    - Recomiendo ejecutar el comando con los permisos de usuario asi evitas ese problema al generar archivos desde adentro cuando tenes una carpeta compartida. Suponiendo que quiero ingresar al contenedor de apache con php 7.4, ejecutamos: `docker exec -it -u $(id -u):$(id -g) apache-php74 /bin/bash`
- Detener todos los contenedores: `docker-compose down` (solo funciona dentro del la carpeta raíz)
- Volver a levantar los contenedores: `docker-compose up -d` (solo funciona dentro del la carpeta raíz)