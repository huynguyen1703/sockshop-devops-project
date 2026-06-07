FROM golang:1.22-alpine AS builder

# Cài đặt git và ca-certificates cần thiết để tải thư viện
RUN apk add --no-cache git ca-certificates

WORKDIR /go/src/github.com/microservices-demo/catalogue

# Sao chép toàn bộ mã nguồn vào container trước
COPY . .

# Xóa thư mục vendor cũ nếu có
RUN rm -rf vendor

# Khởi tạo module (bỏ qua nếu đã tồn tại)
RUN go mod init github.com/microservices-demo/catalogue || true

# -------------------------------------------------------------
# FIX LỖI: Hạ cấp apache/thrift xuống v0.13.0 để giải quyết triệt để 
# lỗi lệch pha hàm số (thiếu context.Context) với zipkin-go-opentracing
# -------------------------------------------------------------
RUN go mod edit -replace github.com/go-kit/kit=github.com/go-kit/kit@v0.3.0 && \
    go mod edit -replace github.com/Sirupsen/logrus=github.com/sirupsen/logrus@v1.8.1 && \
    go mod edit -replace github.com/openzipkin/zipkin-go-opentracing=github.com/openzipkin-contrib/zipkin-go-opentracing@v0.3.4 && \
    go mod edit -replace github.com/go-sql-driver/mysql=github.com/go-sql-driver/mysql@v1.6.0 && \
    go mod edit -replace github.com/prometheus/client_golang=github.com/prometheus/client_golang@v1.11.0 && \
    go mod edit -replace github.com/prometheus/common=github.com/prometheus/common@v0.26.0 && \
    go mod edit -replace golang.org/x/net=golang.org/x/net@v0.17.0 && \
    go mod edit -replace github.com/Shopify/sarama=github.com/Shopify/sarama@v1.30.0 && \
    go mod edit -replace github.com/apache/thrift=github.com/apache/thrift@v0.13.0

# Chạy tidy với cờ tương thích phiên bản Go 1.22
RUN go mod tidy -compat=1.22

# Biên dịch ứng dụng tĩnh (Static Binary)
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app ./cmd/cataloguesvc

# -------------------------------------------------------------
# Sử dụng Multi-stage build để tạo image cuối siêu nhẹ
# -------------------------------------------------------------
FROM alpine:3.19
RUN apk --no-cache add ca-certificates
COPY --from=builder /app /app

CMD ["/app", "-port=80"]