# Investigación de cómo usar un contenedor de MongoDB como cliente

## Introducción

Se requiere usar una instancia de mongo no como servidor de base de datos, sino como cliente. Esto está levemente introducido en la [documentación oficial](https://hub.docker.com/_/mongo/).

## Análisis de la documentación

En primer lugar, debemos tomar como referencia el comando que aparece en la documentación:

```shell
docker run -it --link some-mongo:mongo --rm mongo sh -c 'exec mongo "$MONGO_PORT_27017_TCP_ADDR:$MONGO_PORT_27017_TCP_PORT/test"'
```

Es conveniente analizar el significado de estos parámetros:

* ***--link***: es una opción desfasada para conectar contenedores, ya que actualmente la forma [recomendada](https://stackoverflow.com/questions/41294305/docker-compose-difference-between-network-and-link/41294598#41294598) es usar **docker networks**
* ***--rm***: es una opción que permite que el contenedor se elimine al ser parado
* ***exec mongo***: remplaza la *shell* por *mongo*
* ***sh -c argumento***: fuerza a que sea *sh* lance *argumento* en vez del intérprete por defecto. Este ejemplo se ve mejor ejecutando por ejemplo: ```python -c 'print(2 + 2)```


Tambien es interesante conocer los comandos de MongoDB. Para ello, voy a usar los comandos ```man```:

* ***mongod***:  Como se ve en el manual:

>mongod  is  the  primary  daemon process for the MongoDB system. It handles data requests, manages data access, and performs background management operations.

Es decir, es el motor de la base de datos, y es la opción por defecto de la imagen de Mongo, como puede leerse en el [Dockerfile](https://github.com/docker-library/mongo/blob/58bdba62b65b1d1e1ea5cbde54c1682f120e0676/3.0/Dockerfile)