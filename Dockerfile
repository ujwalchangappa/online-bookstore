FROM openjdk:17
WORKDIR /app
COPY ./target/onlinebookstore.war app.war
ENTRYPOINT ["java", "-jar", "app.war"]

