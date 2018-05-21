# Introducción a los Kubernetes

## Arquitectura de los cubernetes

La arquitectura de los kubernetes es cliente-servidor. Entonces tenemos un servidor que tiene instalado el ***Kubernetes Master*** y varias máquinas Linux con los ***Nodos Kubernetes***.

### Kunernetes Master

Esta parte presenta un *Controller Manager*, sobre el que se basan *etcd*, *API Server* y *Scheduler*

* **Controller Manager**: Es el componente responsable de la mayoría de controladores que regulan el estado del cluster y realizan una tarea. Puede pensarse en él como un *daemon* que corre en un bucle infinito y recolecta información para enviar al *API Server*. Para esta tarea ejecuta una serie de distintos **controladores**, traajando para aunar esta información compartida del clúster y realizar los cambios para conseguir poner al servidor en el estado deseado.

* **etcd**: Es una base de datos *clave -> valor* que almacena información sobre la configuración. La información se puede distribuir a través de los distintos nodos del clúster, aunque únicamente accesible a través del **API Server**, por motivos de seguridad.

* **API Server**: Expone la API REST de Kubernetes, permitiendo su uso cuando se opere en el clúster. Implementa una interfaz para poder establecer la comunicación con distintas aplicaciones y librerías.

* **Scheduler**: Es un servicio responsable de distribuir la carga de trabajo. Se responsabiliza de monitorizar la carga de trabajo en los nodos y realocarlos según haya recursos disponibles. En otras palabras, este mecanismo aloca las pods en los nodos disponibles.

### Kubernetes Nodes

Los nodos tienen como base el *Proxy Service*, sobre el que se basan *Docker* y *Kubelet Service*, a través de los cuales el nodo interactuará con el **Kubernetes Master**.

* **Kubernetes Proxy Service**: Corre en cada nodo y se asegura de que los servicios estén disponibles para el host externo. Se encarga de enviar las peticiones a los contenedores adecuados, además de realizar tareas básicas de balanceo de carga, así como de asegurarse de que la red es predecible, aislada y accesible.

* **Docker**: El contenedor con la aplicación del nodo.

* **Kubelet Service**: Es un pequeño servicio que interacciona con el **master** para recibir comandos, siendo el responsable de gestionar la información de control. El *Kubelet* ausme la responsabilidad de mantener el estado de trabajo y administrar reglas de red, redirección de puertos... **del contenedor**.