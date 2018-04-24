FROM centos:7

# Install Python and Supervisor
RUN yum -y install python-setuptools \
&& mkdir -p /var/log/supervisor \
&& easy_install supervisor

# Copy its configuration 
COPY ./conf/supervisord.conf /etc/supervisord.conf

# Install Apache
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all

# Open required ports
EXPOSE 80

# Add scripts: Not needed anymore because of supervisord
# ADD ./scripts/startServer.sh /startServer.sh
# RUN chmod -v +x /startServer.sh

# Entrypoint
CMD ["/usr/bin/supervisord"]
