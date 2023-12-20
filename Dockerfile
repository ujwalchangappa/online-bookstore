FROM openjdk:17
WORKDIR /app
COPY ./Online-Bookstore/target/onlinebookstore.war app.jar
ENTRYPOINT ["java", "-jar", "onlinebookstore.war"]
