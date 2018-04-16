FROM openjdk:8-jdk

ADD app.war /app.war
EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.data.mongodb.uri=mongodb://spring-demo-mongo/users", "-jar","/app.war"]
