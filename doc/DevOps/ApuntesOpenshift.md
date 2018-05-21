# Apuntes de introducción a OpenShift

## Arquitectura de contenedores

**Contenedor**: *Trozo aislado dentro de un sistema operativo*

* Se aíslan dentro del sistema operativo
* Son más rápidos de deplegar
* Menos recursos

## Docker

**Es la *implementación* de los contenedores.**

* Cliente: es lo que corre los comandos de docker
* Host: Tiene el daemon de docker y responde a los comandos del cliente

El cliente y host pueden estar en el mismo equipo o no

* Contenedores: La base de docker
* Imágenes: Plantillas para contenedores
* Registros: Dónde se almacenan las imágenes

Ejemplo

---

* Pones docker pull mysql en el cliente de docker
* El host busca la imagen en su repositorio de imágenes. Si no la tiene, va a un registro a buscar la imagen de mySql
* Si la encuentra, coge la imagen y la pone en su repositorio
* Pones docker run
* El host coge esa imagen de su repositorio y crea un contenedor basado en esa imagen

---

Docker es la **implementación** de los contenedores y se basa en el uso de *namespaces*,*control groups*, *se linux*

* **Namespaces**: Docker crea uno para cada contenedor, así se protegen sus procesos y no interactúan entre sí cuando no es necesario
* **Control Groups**: particionan los procesos para proteger al host físico de que algo use muchos recursos y pueda perjudicar al host
* **SE linux**: seguridad contenedor - contenedor y contenedor - host

## Kubernetes y OpenShift

Kubernetes es una capa encima de docker.
Los contenedores suelen fallar por su naturaleza. Los kubernetes están pensados para mitigar esta predisposición a fallar. Cuando uno falla crea otro para mantener la integridad del cluster. También se encarga de la orquestación, del cómo conectarlos para tener una arquitectura operativa funcional.

* Orquestacion: conexión de contenedores, como aplicación y mysql. La aplicación necesita mysql, y este contenedor puede fallar y al crear uno nuevo, pues tendrá otra ip. Kubernetes se encarga
* Scheduling: permite planificar cómo crear o escalar los contenedores
* Aislamiento: Se encarga  de que si falla un contenedor no altere a otros contenedores

### Arquitectura

Hay un server maestro (el que procesa los comandos) que gestiona varios nodos. La base de los kubernetes son los ***pods***, que son un contenedor o cojunto de contenedores que están relacionados de alguna manera o comparten recursos / IP
Los servicios permiten persistir las ips de los pods para que puedan comunicarse
Replication COntroller: permite escalar la estructura, así que permite asegurar siempre un mínimo de pods, por ejemplo de mysql
Persistent Volumes: permite persistir los datos en caso de fallo de los contenedores. Ej: si el contenedor de mysql deja de existir, que se pueda seguir teniendo el dato o acceder de otro lado

### OpenShift

Empaqueta docker y kubernetes para tener un flujo de trabajo más fáci e integrado
Se basa en estas tecnologias y añade varias capas y extensiones, con una capa final de  experiencia de usuario para que pueda mejorarse la gestion y la programacion.

## Ejemplo 1: base de datos

DockerHub es un repositorio comunitario de imágenes. Red Hat tiene otro repositorio con algo más de soporte.

docker pull mysql               -> lo baja de dockerhub
docker pull mysql:5.5           -> especificar otras versiones
docker images                   -> lista las imágenes descargadas
docker run *image*              -> crea un contenedor de la imagen
docker run *image* --name       -> lo de antes, pero asignandole un nombre
docker run -d                   -> permite al contenedor seguir corriendo en el bg
docker run -it                  -> permite un shell interactivo de bash para poder gestionar el contenedor
docker exec                     -> acceder al contenedor

Cosas como mysql requieren variables de entorno como contraseñas, nombres, usuarios....
eso se hacer con 
docker run -e "campo"="valor" -e...
docker ps                       -> muestra los contenedores ejecutrandse

## Hacer imágenes personalizadas con Docker

Un *dockerfile* son las instrucciones para generar los contenedores.

En un directorio se crea un archivo de texto (dockerfile) que se ejecutará con el docker build.
Docker indexará el directorio, así que ojo al elegirlo.
El archivo son intrucciones que se ejecutan de forma secuencial.

Destacar que las imágenes pueden construirse en base a otras imágenes ya creadas. Esta herencia permite simplificar los dockerfiles y que sean más fáciles de leer y más sencillos.
esto se hce en el dockerfile con
FROM image

LABEL key="value" -> permite etiquetar
MAINTANER gacho     -> mas metadatis
RUN comando         -> ejecuta un comando
EXPOSE ad           -> es metadato que indica los puertos que se usan. Recalcar que son solo metadatos
ENV                 -> pemite poblar el entorno
ADD, COPY           -> permite integrar ficheros en la imagen. ADD es como copy pero mejor
USER                -> el usuario que correra en el contenedor
ENTRYPOINT          -> comando inicial
CMD                 -> sus argumentos


Si se define el entrypoint, el contenedor será ejecutable
CMD permite ser mas flexible porque al pasar un argumento, toma ese valor automaticmente

Cada instruccion crea un layer, asi que es mejor anidar expresiones en una sola instruccion para reducir el tamaño final mediante &&
Para mantener la legibilidad, puedes usar \ para que un siendo una instruccion, se lea mejor

## Creación de recursos de kubernetes

oc new-app : crear un pod con la aplicacion contenida
oc get: permite obtener recursos
oc describe: permite obtener mucha mas info
oc export: muestra la descripcion del proeycto
oc create, edit, remove: crea, edita, borra los recursos
oc exec: ejecutra

## Source To Image

Es una caracter´sitca de open shift que permite generar un contenedor a partir de código fuente

## Routes

Es la forma de OpenShift de exponer la ip de un servicio a un dns, para poder acceder a ella fuera del host.
Es decir, los routes exponen el servicio al exterior.

## OpenShift WebConsole

Es una aplicación que permite simplificar las tareas de gestión y uso.

