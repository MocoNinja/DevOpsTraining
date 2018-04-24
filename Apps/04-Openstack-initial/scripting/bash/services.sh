#! /bin/bash

ancho_linea=81

function line {
	((contador++))
	while [ $contador -lt $ancho_linea ]; do
		# msg=$msg"+="
		# msg=$msg"="
		msg=$msg+"="
		((contador++))
	done
	echo $msg
}

line
echo "WELCOME TO MY SCRIPT..."
line
line
echo "STARTING DOCKER..."
sudo systemctl start docker
echo "STARTING APACHE..."
sudo systemctl start httpd.service
echo "STARTING MARIADB..."
sudo systemctl start mariadb