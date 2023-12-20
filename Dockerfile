FROM openjdk:17
WORKDIR /app
COPY ./Online-Bookstore/target/onlinebookstore.war /app
ENTRYPOINT ["java", "-jar", "onlinebookstore.war"]
