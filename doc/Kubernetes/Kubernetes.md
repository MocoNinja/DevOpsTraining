# Introducción a Kubernetes

## Overview General

Kubernetes es uno de los sistemas de ***orquestación de contenedores*** más populares. En analogía a nuestro trabajo anterior, es similar a *Docker Swarm*, permitiendo gestionar de forma automática una serie de *contenedores* (en nuestro caso, de **Docker**) en un *clúster* (en nuestro caso, de máquinas virtuales de **OpenStack**), pero con un abanico de posibilidades más rico y amplio.

### Administración

Cuando usábamos *Docker*, ejecutábamos las órdenes a través de su demonio. En el caso de Kubernetes, existe la herramienta ***```kubectl```*** , que actúa como interfaz al administrador del cúster de Kubernetes.

### Clúster

Los contendores orquestados se distribuyen a lo largo de un clúster, de forma similar a lo visto con Docker Swarm. De la misma manera, se sigue una [arquitectura](https://github.com/kubernetes/kubernetes/blob/release-1.2/docs/design/architecture.md)  *maestro-esclavo*, existiendo máquinas que actuarán como **managers** y otras que actuarán como **workers** (en Kubernetes, tradicionalmente denominadas *minions*, aunque actualmente se prefiere el término *nodo*).

### Conceptos básicos

Es importante conocer en general los siguientes conceptos, pues son los fundamentales de Kubernetes:

* ***Kubernetes Master***: Es el elemento del clúster que actúa como tal, teniendo los servicios de gestión que describiremos posteriormente
* ***Nodos***: Son los elementos del clúster que actúan como *workers*
* ***Pods***: Son un conjunto de contenedores y volumes que comparten el mismo *namespace* de red y se pueden comunicar mediante el uso de *localhost*. Se planifican en *Nodos*. **Son efímeros**. Constituyen la unidad más pequeña desplegable  en Kubernetes.
* ***Etiquetas***: Es una dupla clave-valor que se asigna a un *Pod* y permite la comunicación de atributos definidos por el usuario.
* ***Servicios***: Son una forma de abstraer *Pods*, encargádose de su definición y políticas de acceso. Los servicios encuentran a los pods mediante *Etiquetas* y a través de servicios de proxy y dns, permiten su fácil acceso a través de una IP fija a pesar de nu naturaleza efímera.
* ***Controladores de replicación***: Son los encargados de mantener el estado deseado del cúster, gestionando el número de Pods y monitoreándolos.

### Elementos de control

Como se ha mencionado antes, los *nodos **físicos*** que componen el clúster de Kubernetes, pueden actúar como administradores o como trabajadores. Según estas funciones, presentan diferentes características:

* ***Masters***:
  * **ETCD**: es una base de datos encargada de almacenar información relativa a la configuración del clúster, de forma distribuida
  * **Servidor API**: es el punto central de administración de Kubernetes, permitiendo la configuración y organización del clúster. También se encarga de coordinar al *etcd* con los demás servicios, siendo el encargado de validar y configurar todos los datos, servicios, etc., así como de gestionar la replicación y sincronización
  * **Controlador de replicación**: como se ha dicho anteriormente, comprueba el estado de los pods metidante *etcd* y usa la *api* para mantener el estado deseado
  * **Planificador (*Scheduler*)**: asigna las cargas de trabajo a nodos específicos

* ***Minions***:
  * **Kubelet**: es un daemon que corre en cada nodo y se comunica con la *api* del *maestro* para recibir comandos. Se encarga pues de asegurar que los contenedores locales al nodo están corriendo y no tienen problemas, así como administrar las reglas de red, redirección de puertos, etc.. de los contenedores del nodo.
  * **kube-proxy**: es un daemon que corre en cada nodo actuando como un proxy de red y balanceador de carga para los servicios presentes en el nodo. Se encarga de enviar las peticiones a los contenedores adecuados, además de realizar tareas básicas de balanceo de carga, así como de asegurarse de que la red es predecible, aislada y accesible; en resumen, asegura que los servicios estén disponibles para el host externo.

* **Servicio de contenedores**: Suele usarse **Docker** (aunque tambien se puede usar **rkt**).

## Referencias y lecturas avanzadas

* [Documentación Oficial](https://github.com/kubernetes/kubernetes/tree/release-1.2/docs)
* [Overview oficial](https://kubernetes.io/docs/concepts/)
* [Artículo intesante](https://deis.com/blog/2016/kubernetes-overview-pt-1/)
* [Resumen visual](http://omerio.com/2015/12/18/learn-the-kubernetes-key-concepts-in-10-minutes/)
* [Empezando con K8s](http://omerio.com/2016/01/02/getting-started-with-kubernetes-on-google-container-engine/)