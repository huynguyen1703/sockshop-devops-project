# Stage 1: Build (Dùng Maven với Eclipse Temurin Java 11)
FROM maven:3.8.7-eclipse-temurin-11 AS build
WORKDIR /app

# Copy file cấu hình Maven
COPY pom.xml .

# Tải thư viện trước để tận dụng cache
RUN mvn dependency:go-offline

# Copy source code và build
COPY src ./src
RUN mvn package -DskipTests

# Stage 2: Run (Dùng JRE của Eclipse Temurin cho nhẹ)
FROM eclipse-temurin:11-jre
WORKDIR /app

# Copy file .jar từ stage build
COPY --from=build /app/target/*.jar app.jar

# Cổng mặc định của các service Java Sock Shop thường là 80 hoặc 8082
EXPOSE 80
ENTRYPOINT ["java", "-jar", "app.jar"]
