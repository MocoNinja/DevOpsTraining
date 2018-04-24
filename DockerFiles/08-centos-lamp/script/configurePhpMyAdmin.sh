#!/bin/bash

sed -i 's/Require ip 127.0.0.1//g' /etc/httpd/conf.d/phpMyAdmin.conf
sed -i 's/Require ip ::1/Require all granted/g' /etc/httpd/conf.d/phpMyAdmin.conf
sed -i 's/Allow from 127.0.0.1/Allow from all/g' /etc/httpd/conf.d/phpMyAdmin.conf
sed -i "s/'cookie'/'config'/g" /etc/phpMyAdmin/config.inc.php
sed -i "s/\['user'\] .*= '';/\['user'\] = 'root';/g" /etc/phpMyAdmin/config.inc.php
sed -i "/AllowNoPassword.*/ {N; s/AllowNoPassword.*FALSE/AllowNoPassword'] = TRUE/g}" /etc/phpMyAdmin/config.inc.php
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 512M/g' /etc/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 512M/g' /etc/php.ini
sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php.ini