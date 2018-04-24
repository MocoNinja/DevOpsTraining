#! /bin/bash

DB="db"
NETWORK="mongo-lo"
SERVERNAME="mongodb-server"
DATABASE="test"

echo "Creating network $NETWORK"
sudo docker network create $NETWORK
sleep 1

echo "Creating container of Mongo (Server) named $SERVERNAME"
sudo docker run --name=$SERVERNAME --network=$NETWORK -v $DB:/data/db -d mongo
sleep 1


# echo "sudo docker run -it --network=$NETWORK  mongo sh -c 'exec mongo $SERVERNAME/$DATABASE'" # Copiándolo rula
## Creo que esto debe ser porque no está bien creado el contenedor al momento de lanzars
#echo "Creating client attached to $SERVERNAME/$DATABASE"
#sudo docker run -d --network=$NETWORK  mongo sh -c 'exec mongo $SERVERNAME/$DATABASE'
#sleep 1

echo "Configuring launcher..."
if [ -f startClient.sh ]; then
	rm startClient.sh
fi

/bin/cat <<EOM >startClient.sh
sudo docker run --rm --network=$NETWORK  -it mongo sh -c 'exec mongo $SERVERNAME/$DATABASE'
EOM

chmod +x startClient.sh

echo "Launcher created!"
sleep 1

echo "Everything created!"
