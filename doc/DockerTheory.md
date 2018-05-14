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

#### Uso

Vamos a centrarnos en binds y volúmenes. Su funcionamiento ha cambiado respecto de versiones anteriores y, en la actualidad, pueden usarse las flags ```--mount``` o ```--volume``` (equivalente a ```-v```). La diferencia entre estas opciones es que *mount* es más verbose y fácil de usar, mientras que *volume* aúna todas las opciones en una sola instrucción. La opción recomendada es *mount*.

Sus opciones son:

* ```--volume```: consiste en tres opciones separadas por " ***:*** "
  * En el caso de ***binds***:
    * Ruta en el host
    * Ruta en el contenedor
    * (Opcional) opciones de montaje
  * En el caso de ***volúmenes***:
    * Nombre del volumen (vacío para anónimos)
    * Ruta en el contenedor
    * (Opcional) opciones de montaje

* ```--mount```: consiste en varios pares clave-valor (cuyo orden no es importante) separados por comas. La sintaxis de estas tuplas es ```clave=valor(,clave=valor...)```. A continuación se presentan estas opciones:
  * ***type***: Puede ser ***bind***, ***volume***
  * ***source o src***:
    * Para volúmenes, es el nombre el volumen (el campo se omite si el volúmen es anónimo)
    * Para binds, es la ruta en el host
  * ***destination o dst o target***: Es la ruta del contenedor donde se montará
  * ***readonly***: Especifica que sea de sólo lectura el [volumen](https://docs.docker.com/storage/volumes/#use-a-read-only-volume) o el [bind](https://docs.docker.com/storage/bind-mounts/#use-a-read-only-bind-mount)

  Hay ciertas opciones que difieren entre volúmenes y binds:

  * Volúmenes:
    * ***volume-opt***: son opciones separados por comas, también del tipo clave-valor. Pueden requerir escape. Ejemplo: ```docker service create \
     --mount 'type=volume,src=<VOLUME-NAME>,dst=<CONTAINER-PATH>,volume-driver=local,volume-opt=type=nfs,volume-opt=device=<nfs-server>:<nfs-path>,"volume-opt=o=addr=<nfs-address>,vers=4,soft,timeo=180,bg,tcp,rw"'
    --name myservice \
    <IMAGE>```
  * Binds:
    * ***bind-propagation***: se encarga de configurar la [bind-propagation](https://docs.docker.com/storage/bind-mounts/#configure-bind-propagation), que es un aspecto de configuración avanzado que cae fuera del *scope* de esta guía

En el caso de **volúmenes**, estas dos flags pueden ser usadas indistintamente. En el caso de **binds**, debido a razones históricas, esto **no es el caso**. La diferencia es que usando ```--volume```, se creará aunque no exista en el host, pues será creado automáticamente; este no es el caso cuando se usa el flag ```--mount``` y dará error.

### Bibliografía y links interesantes

[Docker Storage Overview](https://docs.docker.com/storage/) \
[Docker Binds](https://docs.docker.com/bind-mounts/) \
[Docker Volumes](https://docs.docker.com/storage/volumes/)