# Documentación de Docker Swarm

## Tutorial

Inicialmente seguimos el [tutorial de Docker Swarm](https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/) para afianzar y practicar los conceptos base.

### Pasos

1. **Crear el Swarm**: El primer paso consiste en elegir un *nodo* que actúe como **manager**. En el iniciaremos el swarm mediante el comando: ```docker swarm init --advertise-addr <MANAGER-IP>```, donde la IP es la fija del propio nodo.
1. **Añadir más nodos**: Con el swarm creado, se procede a añadir más nodos. En **nuestras pruebas iniciales**, vamos a usar 3 nodos: el anteriormente creado, que actuará como *manager* y otros dos que actuarán como *workers*. Para unir estos dos nodos, hace falta el **Token** que se ha generado al iniciar el swarm (en la *cheatsheet* se puede ver el comando que permite volver a mostrar este token). El comando a utilizar es: ```sudo docker swarm join \
  --token  TOKEN \ IP:2377```
1. **Servicios: Crear y gestionar**: Para hacer pruebas, se han seguido los pasos en los que se creaban servicios, y en los que se [actualizaban](https://docs.docker.com/engine/swarm/swarm-tutorial/rolling-update/), reescalaban, borraban, etc... así como el efecto que tiene en los contenedores quitar nodos.

## Cheatsheet

### Gestión de nodos

* **Forzar redistribución de las tareas en los nodos**: ```sudo docker services update --force HASH```
* **Obtener los token para añadir otro nodo al swarm:**
  * *Para unir un **worker***: ```sudo docker swarm join-token worker```
  * *Para unir un **manager***: ```sudo docker swarm join-token manager```
    * **NOTAR** que para poder unir un nodo, es imperativo que la opci�n ```"live-restore``` estéa *true* en ```/etc/docker/daemon.json```
* **Modificar el estado de un nodo:**: ```sudo docker node update --availability ESTADO NODO```
  * active: activo, el nodo se usa con regularidad
  * drain: inactivo, se especifica que los contenedores **del swarm** se muevan a otros nodos y no se alocan en él nuevos. Es interesante recalcar que si a un manager se le aplica esta opción, no ejecutará réplicas como otro worker
* **Modificar el rol de un nodo**:
  * De worker a manager --> ```sudo docker node promote NODO```
  * De manager a worker --> ```sudo docker node demote NODO```
* **Inspeccionar el proceso del servicio para ver que falla**: ```docker service ps --no-trunc ID```

### Gestión de servicios

* **Crear un servicio**: ```sudo docker service create --replicas NUMERO --name NOMBRE IMAGEN```
  * Donde --replicas hace referencia al número de contenedores que se desea mantener en todo momento
* **Escalar un servicio a NUMERO instancias**: ```sdudo docker service scale SERVICIO=NUMERO```
* **Inspeccionar un servicio**: ```sudo docker service inspect SERVICIO```
  * Por defecto devuelve un JSON. Puede obtenerse texto más legible mediante la opción ```--pretty```
* **Listar servicios:**: ```sudo docker service ls```
* **Información sobre los contenedores del servicio**: ```sudo docker service ps SERVICIO```
* **Borrar un servicio**: ```sudo docker service remove SERVICIO```
