
FROM maven:3.6.3-jdk-8-slim AS builder

WORKDIR /usr/src/app
COPY . .

RUN mvn clean package -DskipTests -DallowParameterNames=true

FROM eclipse-temurin:8-jre-alpine

WORKDIR /app

RUN addgroup -g 10001 mygroup && \
    adduser -g "Carts user" -D -H -G mygroup -s /sbin/nologin -u 10001 myuser

COPY --from=builder /usr/src/app/target/*.jar /app/carts.jar

RUN chown -R myuser:mygroup /app
USER myuser

ENV JAVA_OPTS="-Xms64m -Xmx128m -XX:+UseG1GC"

EXPOSE 80

CMD ["sh", "-c", "java $JAVA_OPTS -jar /app/carts.jar --port=80"]

