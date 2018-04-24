#! /bin/bash

echo "Preparing MariaDB Database..."
systemctl status mariadb
systemctl start mariadb
echo "MariaDB up & running!"