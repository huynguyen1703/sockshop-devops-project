
FROM maven:3.9.6-eclipse-temurin-8 AS builder

WORKDIR /usr/src/app

COPY pom.xml .

RUN mvn dependency:go-offline -B

COPY src ./src

RUN mvn clean package -DskipTests

FROM eclipse-temurin:8-jre-alpine

RUN apk add --no-cache curl

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder --chown=appuser:appgroup /usr/src/app/target/*.jar ./app.jar

USER appuser

EXPOSE 80

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar", "--port=80"]