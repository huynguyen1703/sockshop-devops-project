# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
FROM golang:1.25-alpine AS builder

ENV GOTOOLCHAIN=local

WORKDIR /go/src/github.com/microservices-demo/catalogue
COPY . .

# Xóa thư mục vendor cũ
RUN rm -rf vendor

# Khởi tạo go module mới
RUN go mod init github.com/microservices-demo/catalogue || true

# 3. BẢN VÁ CHỐT HẠ: Ép dùng Zipkin v0.4.5 (bản trước khi bị đổi tên repo)
RUN go mod edit -replace github.com/openzipkin/zipkin-go-opentracing=github.com/openzipkin/zipkin-go-opentracing@v0.4.5

# Tải và dọn dẹp các thư viện
RUN go mod tidy -mod=mod || true

# Biên dịch mã nguồn
RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -a -installsuffix cgo -o /app ./cmd/cataloguesvc