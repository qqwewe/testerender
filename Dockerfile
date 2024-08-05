FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /app/target/vs14-back-banco-0.0.1-SNAPSHOT.jar vs14-back-banco.jar
EXPOSE 8080

COPY --from=build /target/pessoaapi-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
