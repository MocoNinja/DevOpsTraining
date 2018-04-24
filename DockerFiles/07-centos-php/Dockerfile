# Use the image create in exercise 06 as base
FROM centos_httpd

# Install PHP
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install php php-devel php-gd php-pdo \ 
    php-soap php-xmlrpc php-xml

# Install source code under /var/www/html
COPY ./script/prepareWebApp.sh /prepareWebApp.sh
RUN chmod -v +x /prepareWebApp.sh && sh /prepareWebApp.sh
COPY src/*.html /var/www/html/Webapp/
COPY src/js/*.js /var/www/html/Webapp/js/
COPY src/css/*.css /var/www/html/Webapp/css/
COPY src/php/*.php /var/www/html/Webapp/php/