FROM openjdk:8-jdk
COPY app.war /app.war
EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.data.mongodb.uri=mongodb://spring-mongo-compose/guestbook-app-compose", "-jar","/app.war"]
