#! /bin/bash

echo "Cleaning previous data..."
rm -rf /run/httpd/* /tmp/httpd*
echo "Starting server..."
exec /usr/sbin/apachectl -DFOREGROUND