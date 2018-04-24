FROM ubuntu:latest

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

COPY /conf/apache-config.conf /etc/apache2/sites-enabled/000-default.conf
COPY /conf/install.sh /
COPY webapp.tar.gz /webapp.tar.gz

RUN apt-get update && apt-get install -y \
	figlet \
    apache2 \
	php7.0 \
	libapache2-mod-php7.0 

EXPOSE 22 80
RUN /bin/bash install.sh
CMD /usr/sbin/apache2ctl -D FOREGROUND
