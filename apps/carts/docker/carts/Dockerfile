# ==========================================
# STAGE 1: Build file .JAR với Java 8 chuẩn gốc của dự án
# ==========================================
FROM maven:3.6.3-jdk-8-slim AS builder

WORKDIR /usr/src/app

# Copy toàn bộ mã nguồn của carts vào container
COPY . .

# Tiến hành đóng gói ứng dụng, bỏ qua test
RUN mvn clean package -DskipTests -DallowParameterNames=true

# ==========================================
# STAGE 2: Chạy ứng dụng thực tế gọn nhẹ với JRE 8 chuẩn Temurin
# ==========================================
# BẢN VÁ: Thay thế openjdk bằng eclipse-temurin vì bản cũ đã bị Docker Hub xóa bỏ
FROM eclipse-temurin:8-jre-alpine

WORKDIR /app

# Tạo user không có quyền root (Non-root) để đảm bảo bảo mật cho hệ thống
RUN addgroup -g 10001 mygroup && \
    adduser -g "Carts user" -D -H -G mygroup -s /sbin/nologin -u 10001 myuser

# Bốc file .jar vừa được build thành công từ STAGE 1 sang STAGE 2
COPY --from=builder /usr/src/app/target/*.jar /app/carts.jar

# Phân quyền sở hữu file jar cho non-root user
RUN chown -R myuser:mygroup /app
USER myuser

# Cấu hình môi trường chạy Java tối ưu cho container
ENV JAVA_OPTS="-Xms64m -Xmx128m -XX:+UseG1GC"

EXPOSE 80

CMD ["sh", "-c", "java $JAVA_OPTS -jar /app/carts.jar --port=80"]