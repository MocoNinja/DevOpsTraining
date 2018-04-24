#! /bin/bash
echo "Starting MySQL Server"
/usr/sbin/mysqld &
echo "Starting apache Server"
/usr/sbin/apache2ctl -D FOREGROUND

while [ 1 > 0 ]; do
	echo "Estoy vivo..."
	sleep 2
done
