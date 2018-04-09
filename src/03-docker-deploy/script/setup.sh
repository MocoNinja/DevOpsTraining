#! /bin/bash

echo "Ensuring correct directory tree..."

if [ ! -d /apps/bin ]; then
    mkdir -p /apps/bin/
fi

echo "Directories created!"