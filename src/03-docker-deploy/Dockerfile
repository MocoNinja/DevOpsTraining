FROM ubuntu:xenial

# Install Java and Maven
RUN apt-get -y update \
    && apt install -y openjdk-8-jdk \
    maven

# Add files
RUN mkdir -p /apps/bin
COPY ./src/app.jar /apps/bin/app.jar

# Configure ENV

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# Expose Tomcat
EXPOSE 8080

# Run the app
CMD java -jar /apps/bin/app.jar

