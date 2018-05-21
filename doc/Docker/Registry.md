# Registro de Docker

## Introducción

Al empezar a tener distintos nodos, se ha visto el problema de la disponibilidad de imágenes, ya que al redistribuir un servicio por estos nodos, no siempre tenían la imagen deseada. La opción menos favorable era hacer ssh a cada nodo y bajarla/construirla manualmente. Una opción mejor es subirlas a *DockerHub*. Otra opción es crear un servicio que actúe como registro privado, desde el que todos los nodos puedan obtener las imágenes específicas a utilizar.

## Consideraciones de seguridad

Para esta prueba, se han ignorado todas las configuraciones de redes, acceso y seguridad (cosa que es, evidentemente, nada recomendable para producción).
Para esto, hay que asegurar que **todos** los nodos que participen tengan la siguiente línea en el archivo de configuración ```/etc/docker/daemon.json```:
```shell
"insecure-registries": ["192.168.X.Y:5000"]
```

## Comandos para la gestión de imágenes:

Hay que *tagear* una imagen y pushearla a este registro local, para que luego se pueda pullear desde consola o, preferiblemente, desde el archivo de configuración del swarm. Los comandos son:

* ```sudo docker tag image-name:tag-name ip:puerto/image-name:tag-name```
* ```sudo docker push ip:puerto/image-name:tag-name```

Donde ip es la ip del swam y el puerto es, *generalmente*, 5000, según se especifique.


## Otros comandos

* ***Listar imágenes***: ```curl IP:PORT/v2/_catalog```
