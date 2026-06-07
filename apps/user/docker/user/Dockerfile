# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY . .

# 1. BẢN VÁ: Xóa thư mục vendor cũ của tác giả để tránh xung đột
RUN rm -rf vendor

# Khởi tạo go module
RUN go mod init github.com/microservices-demo/user || true
RUN go mod tidy || true

# 2. BẢN VÁ: Thêm cờ -mod=mod để ép Go compiler dùng hệ thống Go Modules mới
RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -a -installsuffix cgo -o user-app .

# ==========================================
# STAGE 2: Chạy thực tế (Production) - GIỮ NGUYÊN RẤT ĐẸP
# ==========================================
FROM alpine:3.19

RUN apk --no-cache add ca-certificates

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder --chown=appuser:appgroup /app/user-app .

USER appuser

EXPOSE 8084

CMD ["./user-app", "-port=8084"]