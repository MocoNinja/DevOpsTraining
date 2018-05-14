# Profundización en algunos aspectos de Docker

## Introducción

Tras realizar los ficheros de este repositorio, se han conseguido seguir tutoriales y aplicar conceptos. Sin embargo, en el proceso del estudio de Docker y sus tecnologías relacionadas, se ha visto la necesidad de afianzar y entender ciertos aspectos de forma más exhaustiva.
Aquí se recogen algunas pinceladas clave de estos aspectos.

## Almacenamiento y persistencia

Por defecto, Docker guarda cualquier cosa que genere en su capa escribible. Esto hace que esta información sea **volátil** y que también sea **difícil de compartir**, ya que está íntimamente relacionada al host que corre el contenedor.

Existen tres formas de conseguir esta persistencia:

* ***Volúmenes*** : Son la manera preferida de gestionar la persistencia en Docker. Son almacenados en el sistema de archivos del host, en un directorio que administra Docker (```/var/lib/docker/volumes/```) que **no debería ser gestionado por procesos externos a docker**
* ***Bind mounts ("montado enlazado")*** : Pueden estar almacenado en **cualquier** lugar del host y ser modificados por procesos externos a docker
* ***tmpfs mounts (sólo en Linux)*** : es una forma de almacenamiento en memoria, por lo que nunca se llega a escribir nada en el host

Un overview de estos métodos puede verser en la siguiente imágen:
\
\
![Arquitectura general](./caps/docker-mounts-01.png)

### Binds

Está disponible desde el inicio de docker y suele recomendarse actualmente el uso de volúmenes en vez de binds. Su funcionamiento consiste en el montaje de un fichero o directorio del host en el contenedor mediante su *ruta absoluta*. Esta ruta o fichero se crearán por Docker si no existen.

Aparte de no tener *CLI*, la diferencia clave respecto a un volumen es que la carpeta en el host puede ser afectada por procesos de este.

### Volúmenes

En su funcionamiento, son prácticamente idénticos a los *bindeados*: al ser **creado**, se almacena en el sistema de archivos del host que corre el contenedor de docker; al ser **montado** en el contenedor, dicho directorio es el montado en el contenedor.

La diferencia clave es que los volúmenes son **administrados por Docker**, por lo que pueden gestionarse mediante *CLI*, con comandos tales como ```docker volume create``` y ```docker volume prune```. Los volúmenes pueden ser usados por varios contenedores simultáneamente y no dejan de existir cuando no hay contenedores que los usen. Otras diferencias es que estos volúmenes pueden ser *anónimos* o tener un *nombre*, así como la existencia de *drivers de volumen*, que permiten, por ejemplo, usar almacenamiento en la nube.

### Tmpfs

Los ficheros **no** se persisten en disco, por lo que se pierden cuando se para el contenedor.

### Bibliografía y links interesantes

[Docker Storage Overview](https://docs.docker.com/storage/)