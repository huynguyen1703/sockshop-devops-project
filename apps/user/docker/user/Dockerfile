# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY . .

# Khởi tạo go module
RUN go mod init github.com/microservices-demo/user || true
RUN go mod tidy || true

# Biên dịch mã nguồn thành file nhị phân tên là 'user-app'
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o user-app .

# ==========================================
# STAGE 2: Chạy thực tế (Production)
# ==========================================
FROM alpine:3.19

# Cài đặt chứng chỉ mạng cơ bản
RUN apk --no-cache add ca-certificates

WORKDIR /app

# Tạo user không có quyền root (Non-root user)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy file binary từ STAGE 1 sang
COPY --from=builder --chown=appuser:appgroup /app/user-app .

# Chuyển sang user thường
USER appuser

# Expose port 8084
EXPOSE 8084

# Chạy ứng dụng
CMD ["./user-app", "-port=8084"]