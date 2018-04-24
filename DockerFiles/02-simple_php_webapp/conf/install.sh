#! /bin/bash

touch /log

if [ -f webapp.tar.gz ]; then
    echo "Encontrado el código fuente empaquetado. Descomprimiendo..." >> /log;
    tar -xf webapp.tar.gz
	echo "Borrando comprimido..." >> /log;
	rm webapp.tar.gz
fi

if [ -d webapp ]; then
    echo "Código fuente encontrado con éxito..." >> /log;
    if [ -d /var/www/html/webapp ]; then
        echo "Encontrado código anticuado. Eliminándolo..." >> /log;
        rm -rf /var/www/html/webapp
    else 
        echo "Directorio de trabajo limpio!" >> /log;
    fi
    echo "Copiando código fuente..." >> /log;
    cp -r webapp /var/www/html
else
    echo "ERROR CRÍTICO: NO HAY CÓDIGO FUENTE!" >> /log;
fi
