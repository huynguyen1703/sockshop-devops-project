# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
# Dùng image Maven đi kèm Java 8 bản an toàn (Eclipse Temurin)
FROM maven:3.9.6-eclipse-temurin-8 AS builder

WORKDIR /usr/src/app

# Chỉ copy file cấu hình Maven vào trước để cache lại các thư viện
COPY pom.xml .

# Tải trước các thư viện (giúp các lần build sau nhanh hơn rất nhiều)
RUN mvn dependency:go-offline -B

# Copy toàn bộ source code vào
COPY src ./src

# Build ra file .jar (bỏ qua bước chạy test tự động để build nhanh hơn)
RUN mvn clean package -DskipTests

# ==========================================
# STAGE 2: Chạy thực tế (Production)
# ==========================================
# Chỉ cần JRE (Java Runtime Environment) cực nhẹ trên nền Alpine
FROM eclipse-temurin:8-jre-alpine

# Cài đặt thêm curl hoặc các gói cơ bản nếu ứng dụng cần gọi API nội bộ
RUN apk add --no-cache curl

WORKDIR /app

# Tạo user không có quyền root (Non-root user) để bảo mật
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy file .jar thành phẩm từ STAGE 1 sang STAGE 2
# Dùng wildcard *.jar vì tên file của carts/orders/shipping sẽ khác nhau
COPY --from=builder --chown=appuser:appgroup /usr/src/app/target/*.jar ./app.jar

# Chuyển sang user thường để chạy app
USER appuser

# Expose port mặc định của cả 3 dịch vụ này đều là 80
EXPOSE 80

# Chạy file jar
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar", "--port=80"]