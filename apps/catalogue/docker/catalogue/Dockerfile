# ==========================================
# STAGE 1: Xây dựng (Builder) - Chuẩn hóa Modules ổn định
# ==========================================
FROM golang:1.17-alpine AS builder

WORKDIR /go/src/github.com/microservices-demo/catalogue
COPY . .

# Xóa thư mục vendor cũ (nếu có) để không xung đột với Go Modules
RUN rm -rf vendor

# Khởi tạo gói quản lý module
RUN go mod init github.com/microservices-demo/catalogue || true

# 🎯 BẢN VÁ 1: Sửa lỗi Zipkin bằng cách ép về tag v0.4.0 (Không bị lỗi trùng module path)
RUN go mod edit -replace github.com/openzipkin/zipkin-go-opentracing=github.com/openzipkin/zipkin-go-opentracing@v0.4.0

# 🎯 BẢN VÁ 2: Ép cứng go-kit về v0.5.0 để giữ nguyên cấu trúc hàm NewServer(ctx, ...)
RUN go mod edit -replace github.com/go-kit/kit=github.com/go-kit/kit@v0.5.0

# Chạy tidy để đồng bộ và khóa chặt phiên bản các thư viện cổ điển
RUN go mod tidy

# Biên dịch ứng dụng (Bỏ cờ -mod=mod để Go tuân thủ tuyệt đối file go.mod vừa tạo)
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app ./cmd/cataloguesvc