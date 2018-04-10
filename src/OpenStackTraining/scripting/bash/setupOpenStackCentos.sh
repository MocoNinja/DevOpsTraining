#!/bin/bash

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
echo "KILLING SELINUX..."
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
line
echo "UPDATING THE SYSTEM..."
sudo yum update -y
line
echo "INSTALLING PACKAGES..."
sudo yum install -y vim docker htop git git-all golang java-1.8.0-openjdk groovy maven https curl mariadb-server mariadb php php-mysql
line
echo "DO NOT FORGET TO REBOOT!!!"
line