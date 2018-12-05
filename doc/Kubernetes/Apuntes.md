# Kubernetes Learning

## Instalación

En primera instancia se va a crear un clúster mononodo para poder empezar la parte práctica del aprendizaje.

Las guías principales a seguir son estas que inidican [cómo instalar *kubeadm*](https://kubernetes.io/docs/setup/independent/install-kubeadm/) y [cómo instalar el *clúster*](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/).

Se han seguido en un Centos7 y se ha podido instalar sin problema el clúster, usando ***Flannel*** como *add-on de red*.

En este paso, el único paso problemático a tener en cuenta es que al desactivar la *swap*, si lo hacemos sin pensar, podemos hacer que montemos nuestro sistema de archivos en modo de *sólo lectura*. Esto se puede arreglar mediante:

```mount / -o remount,rw```

## Conceptos

Antes de empezar a desplegar aplicaciones como un cosaco, vamos a intentar entender qué hace cosa de Kubernetes.

### Objetos

Un **objeto** de kubernetes es la entidad que usa para representar el estado del clúster. Indica el **estado deseado** del clúster, que k8s tendrá que *asegurar y mantener*.

Sus caracterísicas identificativas son:

* nombre: Es un *string* especificado por el cliente. Hace referencia a un **recurso URL**, por ejemplo ```/api/v1/pods/my-name```. El nombre puede estar asignado únicamente a un objeto en un instante y por convenio los nombres deben obedecer el siguiente formato:
  * 253 como máximo de longitud
  * Tener como carácteres *minúsculas*, *-* o *.*
* uid:	Es un *string* generado por *Kubernetes*. Es único en todo el periodo de vida del clúster.

### Namespaces

Un mismo clúster **físico** de Kubernetes puede soportar varios clústeres **virtuales**. Estos últimos son los que se denominan *namespaces*.

Las características que otorgan los *namespaces* son:

* Definen distintos alcances (*scope*) para los **nombres**, por lo que permite usar el mismo **nombre** en recursos que están en distintos **namespaces**
* Permiten distribuir los recursos a través del uso de **cuotas**

### Labels

Las *etiquetas* son recursos que se asocian a un **objeto** y dan información sobre este. Es importante notar que dicha información es importante para el *usuario*, pero que **carece de significado** para el *clúster*.

### Annotations

Las anotaciones son *prácticamente* equivalentes a las *etiquetas*, con la pequeña diferencia de matiz de que una etiqueta pretender *ser usada para encontrar objetos que satisfacen ciertas condiciones*, mientras que las anotaciones * no están destinadas a filtrar e indentificar objetos*

### Field selectors

Parcialmente relacianado con lo anterior, pueden usarse selectores personalizados por campo para poder filtrar los resultados de los comandos.

Ejemplos serían:

* ```kubectl get pods --field-selector status.phase=Running```
* ```kubectl get namespaces --field-selector metadata.name!=javi```
* ```kubectl get statefulsets,services --field-selector metadata.namespace!=default,metadata.name=javi```

Para usar filtrado por las etiquetas no hay que usar el selector por campo, sino filtrar por etiquetas directamente usando comandos similares a estos:

* ```kubectl get pods -l environment=production,tier=frontend ``
* ```kubectl get pods -l 'environment in (production),tier in (frontend)'```
* ```kubectl get pods -l 'environment in (production, qa)'```

### Pods

Un **pod** es la unidad mínima que puede crearse y desplegars en Kubernetes. Es una encapsulación de uno o varios contenedores y/o recursos de almacenamiento que comparten una misma IP. Es decir, es un **grupo de recursos compartidos que necesitan correr de forma conjunta**, representando una unidad de proceso de la aplicación.

Los pods **no están pensados para ser lanzados manual ni invidualmente*, ya que son *efímeros* y no se curan, se destruyen y se vuelven a lanzar.

Todos los contenedores de un pod comparten la IP y el nombre de cred, pudiendo comunicarse entre si mediante referencias a *localhost*. De la misma manera, un pod puede especificar un conjunto de volúmenes de almacenamiento compartidos, pudiendo ser accedidos por cada contenedor del pod.

### Controladores

Kubernetes es un **orquestador** de contenedores. Es decir, el fundamento de la herramienta es que los pods que se crean puedan ser gestionados de forma automática según se cumplan o no ciertas condiciones.

Es por ello que existen distintos tipos de *controladores* que se encargan de esta tarea.

La idea fundamental del funcionamiento es que, según la descripción especificada, se alcance el estado deseado del clúster.

#### Jobs

Están pensados para correr una tarea. Podría pensarse que este caso de uso se simplifica usando simplemente un **pod**, pero el uso de un **job** permite **asegurar** que el proceso se ha realizado correctamente (ya que si el pod encargado del proceso no llega a terminar la tarea se lanzará otro en su lugar) y permite lanzar varios pods de forma concurrente.

Se ha guardado en *resources* la plantilla de ejemplo de Job que usa la documentación oficial

#### Daemon sets

Están pensados para garantizar que cada nodo del clúster (o una serie de nodos) va a contener una copia del pod deseado. Esto es útil para pods que contienen almacenamiento, monitorización, logs...

#### Replication Controllers y Replica Sets

Estos dos objetos son prácticamente análogos, siendo el *Replica Set* una evolución del *Replication Controller*, destinada a sustituirlo.

El fundamento del objeto es garantizar que un pod va a estar, como mínimo siempre corriendo, levantando una copia si este dejara de funcionar cualquier razón. De la misma manera, el objeto también permite mantener varias réplicas de un mismo pod para asegurar que el despliegue es *replicado*. Asi mediante estos objetos podemos generar un recurso que especifique "quiero tener 4 instancias de un servidor web nginx".

La diferencia entre los Replication Controllers y los Replica Sets es que estos últimos soportan la nueva forma de seleccionar por conjunto.

Hay que notar que tampoco estos objetos están pensados para ser gestionados directamente, sino que a no ser que planteé usar un despliegue sin necesidad de ser actualizado o que requiera de necesidades personalizadas de orquestación, se recomienda usar **deployments**.

#### Deployments

Como se ha dicho antes, un **deployment** es la descripción declarativa del **estado deseado del despliegue**. Se describel el estado deseado y el **controlador** es el que **cambia el estado actual para adecuarlo en un intervalo controlado**. No hay que tocar manualmente los Replica Sets, sino ir modificando el deployment según las necesidades.

## TutoEjemplos

### Crear mi propio namespace

1. Definir el template del objeto. En este caso, se encuentra en ./resources/javi-ns.yaml
2. Crear el namepsace usando el siguiente comando:
    > ```kubectl create -f ./resources/javi-ns.yml```

### Crear labels y anotaciones: ampliando el namespace anterior

1. Con el nuevo template, se reaplica usando el comando:
    > ```kubectl apply -f ./resources/javi-ns.yml```
2. Podemos ver las label mediante el comando:
    > ```kubectl get namespaces --show-labels```
