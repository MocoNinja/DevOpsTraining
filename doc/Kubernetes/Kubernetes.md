# Introducción a Kubernetes

## Overview General

Kubernetes es uno de los sistemas de ***orquestación de contenedores*** más populares. En analogía a nuestro trabajo anterior, es similar a *Docker Swarm*, permitiendo gestionar de forma automática una serie de *contenedores* (en nuestro caso, de **Docker**) en un *clúster* (en nuestro caso, de máquinas virtuales de **OpenStack**), pero con un abanico de posibilidades más rico y amplio.

### Administración

Cuando usábamos *Docker*, ejecutábamos las órdenes a través de su demonio. En el caso de Kubernetes, existe la herramienta ***```kubectl```*** , que actúa como interfaz al administrador del cúster de Kubernetes.

### Clúster

Los contendores orquestados se distribuyen a lo largo de un clúster, de forma similar a lo visto con Docker Swarm. De la misma manera, se sigue una [arquitectura](https://github.com/kubernetes/kubernetes/blob/release-1.2/docs/design/architecture.md)  *maestro-esclavo*, existiendo máquinas que actuarán como **managers** y otras que actuarán como **workers** (en Kubernetes, tradicionalmente denominadas *minions*, aunque actualmente se prefiere el término *nodo*).

### Elmentos de control

Como se ha mencionado antes, los *nodos **físicos*** que componen el clúster de Kubernetes, pueden actúar como administradores o como trabajadores. Según estas funciones, presentan diferentes características:

* ***Masters***:
  * **ETCD**: es una base de datos encargada de almacenar información relativa a la configuración del clúster, de forma distribuida
  * **Servidor API**: es el punto central de administración de Kubernetes, permitiendo la configuración y organización del clúster. También se encarga de coordinar al *etcd* con los demás servicios, siendo el encargado de validar y configurar todos los datos, servicios, etc., así como de gestionar la replicación y sincronización

## Referencias y lecturas avanzadas

* [Documentación Oficial](https://github.com/kubernetes/kubernetes/tree/release-1.2/docs)
* [Artículo intesante](https://deis.com/blog/2016/kubernetes-overview-pt-1/)
* [Resumen visual](http://omerio.com/2015/12/18/learn-the-kubernetes-key-concepts-in-10-minutes/)
* [Overview oficial](https://kubernetes.io/docs/concepts/)