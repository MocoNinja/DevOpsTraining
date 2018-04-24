FROM ubuntu:latest

# Add Packages
RUN apt-get update && apt-get install -y \
	figlet \
    apache2 \
	php7.0 \
	libapache2-mod-php7.0 

# Configure web server
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
# COPY /conf/apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# Add source code
COPY ./script/prepareWebApp.sh /prepareWebApp.sh
RUN chmod -v +x /prepareWebApp.sh && sh /prepareWebApp.sh
COPY src/*.html /var/www/html/Webapp/
COPY src/js/*.js /var/www/html/Webapp/js/
COPY src/css/*.css /var/www/html/Webapp/css/
COPY src/php/*.php /var/www/html/Webapp/php/

# Open web port
EXPOSE 80


CMD /usr/sbin/apache2ctl -D FOREGROUND


