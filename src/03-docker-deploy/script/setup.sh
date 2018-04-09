#! /bin/bash

echo "Ensuring correct directory tree..."

if [ ! -d /apps/bin ]; then
    mkdir -p /apps/bin/
fi

echo "Directories created!"

echo "Exporting environment variables..."
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
echo "JAVA_HOME SET TO $JAVA_HOME!"

echo "Adding JAVA to path..."
export PATH=$JAVA_HOME/bin:$PATH
echo "Path updated!"

echo $PATH
echo "Finished!"
