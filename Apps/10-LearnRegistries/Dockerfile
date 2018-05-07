FROM openjdk:8-jdk
COPY app.war /app.war
EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.data.mongodb.uri=mongodb://spring-mongo-stack/guestbook-app-stack","-Djava.security.egd=file:/dev/./urandom", "-jar","/app.war"]
