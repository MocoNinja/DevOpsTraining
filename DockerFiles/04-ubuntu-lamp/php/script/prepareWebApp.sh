#! /bin/bash
webapp_name="Webapp"
path=/var/www/html/$webapp_name

echo "Checking if webapp directory exists..."
if [ -d $path ]; then
    echo "Folder already exists. Nothing to do..."
else
    echo "Folder does not exist. Creating..."
    mkdir $path
fi

echo "JavaScript..."
if [ ! -d $path/js ]; then
    mkdir $path/js
fi

echo "CSS..."
if [ ! -d $path/css ]; then
    mkdir $path/css
fi

echo "PHP..."
if [ ! -d $path/php ]; then
    mkdir $path/php
fi
echo "Setup completed!"