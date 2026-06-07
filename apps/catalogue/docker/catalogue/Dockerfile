# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
# 1. BẢN VÁ: Nâng lên hẳn golang:1.25-alpine để chiều lòng thư viện x/net
FROM golang:1.25-alpine AS builder

# 2. Vẫn giữ khóa toolchain để đảm bảo ổn định, không cho nó tự ý nhảy version nữa
ENV GOTOOLCHAIN=local

WORKDIR /go/src/github.com/microservices-demo/catalogue
COPY . .

# Xóa thư mục vendor cũ
RUN rm -rf vendor

# Khởi tạo go module mới
RUN go mod init github.com/microservices-demo/catalogue || true

# Tải và dọn dẹp các thư viện
RUN go mod tidy -mod=mod || true

# Biên dịch mã nguồn
RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -a -installsuffix cgo -o /app ./cmd/cataloguesvc