FROM ubuntu:xenial

# Install Java and Maven
RUN apt-get -y update \
    && apt install -y openjdk-8-jdk \
    maven

# Add files
COPY ./script/setup.sh /setup.sh
RUN chmod -v +x /setup.sh && sh /setup.sh
COPY ./src/app.jar /apps/bin/app.jar

# Expose Tomcat
EXPOSE 8080

# Run the app
CMD java -jar /apps/bin/app.jar

