# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
# 1. BẢN VÁ: Nâng lên golang:1.24 để tương thích với các thư viện hiện tại
FROM golang:1.24-alpine AS builder

# 2. BẢN VÁ: Tắt cơ chế tự động đòi nâng cấp toolchain của Go
ENV GOTOOLCHAIN=local

WORKDIR /go/src/github.com/microservices-demo/catalogue
COPY . .

# Xóa thư mục vendor cũ để tránh xung đột độc hại
RUN rm -rf vendor

# Khởi tạo go module mới
RUN go mod init github.com/microservices-demo/catalogue || true

# Tải và dọn dẹp các thư viện (Bổ sung cờ -mod=mod để ưu tiên Module thay vì Vendor)
RUN go mod tidy -mod=mod || true

# Biên dịch mã nguồn thành file nhị phân độc lập
RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -a -installsuffix cgo -o /app ./cmd/cataloguesvc