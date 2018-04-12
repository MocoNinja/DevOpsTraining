FROM openjdk:8-jdk

ADD app.jar app.jar
RUN sh -c 'touch /app.jar'
ENTRYPOINT ["java", "-Dspring.data.mongodb.uri=mongodb://spring-demo-mongo/users","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
