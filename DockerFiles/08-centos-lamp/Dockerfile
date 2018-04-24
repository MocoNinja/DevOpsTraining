# Use the image create in exercise 06 as base
FROM centos:7

# Install Python and Supervisor
RUN yum -y install python-setuptools \
&& mkdir -p /var/log/supervisor \
&& easy_install supervisor

# Install Apache
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all

# Reconfigure Apache
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/httpd/conf/httpd.conf \
&& chown root:apache /var/www/html \
&& chmod g+s /var/www/html    

# Install MariaDB
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install mariadb

# Configure supervisor
COPY ./conf/supervisord.conf /etc/supervisord.conf

# Install phpMyAdmin
RUN yum -y --setopt=tsflags=nodocs update && \
rpm -iUvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
&& yum -y --setopt=tsflags=nodocs install phpmyadmin 

# Configure phpMyAdmin
COPY ./script/configurePhpMyAdmin.sh /configurePhpMyAdmin.sh
RUN chmod -v +x /configurePhpMyAdmin.sh && sh /configurePhpMyAdmin.sh


# Open Ports
EXPOSE 80 3036

# Entrypoint
CMD ["/usr/bin/supervisord"]