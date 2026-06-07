# ==========================================
# STAGE 1: Xây dựng (Builder) - Chuẩn hóa Modules ổn định
# ==========================================
FROM golang:1.17-alpine AS builder

# 🎯 Cài thêm git vì một số thư viện cũ bắt buộc phải có git mới tải được
RUN apk add --no-cache git

WORKDIR /go/src/github.com/microservices-demo/catalogue
COPY . .

# Xóa thư mục vendor cũ (nếu có)
RUN rm -rf vendor

# Khởi tạo gói quản lý module
RUN go mod init github.com/microservices-demo/catalogue || true

# 🎯 BẢN VÁ 1: Đổi tên Zipkin sang đúng repository đang duy trì mã nguồn cũ
RUN go mod edit -replace github.com/openzipkin/zipkin-go-opentracing=github.com/openzipkin-contrib/zipkin-go-opentracing@v0.4.5

# 🎯 BẢN VÁ 2: Hạ go-kit xuống tận v0.3.0 (Đây là phiên bản cũ còn giữ tham số context.Context)
RUN go mod edit -replace github.com/go-kit/kit=github.com/go-kit/kit@v0.3.0

# 🎯 BẢN VÁ 3: Sửa lỗi phân biệt chữ hoa/thường kinh điển của thư viện logrus
RUN go mod edit -replace github.com/Sirupsen/logrus=github.com/sirupsen/logrus@v1.8.1

# Tải trước các module cần thiết (cho phép bỏ qua lỗi vụn vặt của các module không xài tới)
RUN go mod download || true

# Biên dịch trực tiếp, Go sẽ dùng GOPROXY để tự vá và chỉ tải đúng những gì mã nguồn cần
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app ./cmd/cataloguesvc