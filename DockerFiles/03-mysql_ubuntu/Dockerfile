FROM ubuntu:latest

# No prompts from installing apps
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt install -y \
    apache2 \ 
    php7.0 \
		libapache2-mod-php7.0 \
    mysql-server \
		mysql-client \
		curl
    
# Enable remote access
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Configuration
ADD "startMysql.sh" /start.sh
RUN chmod +x /start.sh
RUN mkdir -p /var/run/mysqld

EXPOSE 3306
    
CMD ["/start.sh"]
