FROM openjdk:8-jre-alpine

WORKDIR /usr/src/app

RUN apk add --no-cache curl

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY target/*.jar ./app.jar

RUN chown -R appuser:appgroup /usr/src/app

USER appuser

EXPOSE 80

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "./app.jar", "--port=80"]