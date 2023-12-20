FROM openjdk:17
WORKDIR /app
COPY ./Online-Bookstore/target/onlinebookstore.war app.war
ENTRYPOINT ["java", "-jar", "app.war"]
