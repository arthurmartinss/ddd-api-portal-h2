FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

COPY portal-corrigido/pom.xml .
RUN mvn dependency:go-offline -B

COPY portal-corrigido/src src
RUN mvn clean package -DskipTests -B

FROM eclipse-temurin:21-jre

WORKDIR /app

ENV SERVER_PORT=10000

COPY --from=build /app/target/*.war app.war

CMD ["java", "-jar", "app.war"]
