#! /bin/bash

TEX_CONF="config.tex"

if [ -z "$1" ]; then
	echo "No se ha pasado fichero de entrada"
	echo "Saliendo..."
	exit
fi

if [ -z "$2" ]; then
	echo "No se ha pasado nombre del fichero de salida"
	echo "Usando valor de la entrada"
	OUT_FILE=$1.pdf
else
	OUT_FILE=$2
fi

echo $OUT_FILE

pandoc $1 --listings -H $TEX_CONF -o $OUT_FILE
