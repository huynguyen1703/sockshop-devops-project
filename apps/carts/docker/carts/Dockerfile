# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
FROM maven:3.9.6-eclipse-temurin-8 AS builder

WORKDIR /usr/src/app

# Copy file cấu hình và toàn bộ mã nguồn vào
COPY pom.xml ./
COPY src ./src

# Đóng gói ra file .jar (Bỏ qua chạy test để chạy cho nhanh)
RUN mvn clean package -DskipTests

# ==========================================
# STAGE 2: Chạy thực tế (Production)
# ==========================================
FROM eclipse-temurin:8-jre-alpine

RUN apk add --no-cache curl

WORKDIR /app

# Tạo user thường để bảo mật
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# ÉP BUỘC lấy file .jar vừa được build thành công từ STAGE 1 sang
COPY --from=builder --chown=appuser:appgroup /usr/src/app/target/*.jar ./app.jar

USER appuser

EXPOSE 80

CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar", "--port=80"]