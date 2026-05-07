FROM golang:1.21-alpine AS builder
RUN apk add --no-cache git
WORKDIR /app
COPY . .

# Xóa bỏ mọi thứ cũ kỹ
RUN rm -rf vendor go.mod go.sum

# Khởi tạo module và ÉP XÁC các thư viện về phiên bản cũ (2018-2019)
RUN go mod init github.com/microservices-demo/catalogue && \
    go mod edit -require github.com/go-kit/kit@v0.8.0 && \
    go mod edit -require github.com/prometheus/client_golang@v0.9.2 && \
    go mod edit -require github.com/gorilla/mux@v1.7.3 && \
    go mod edit -require github.com/opentracing/opentracing-go@v1.1.0 && \
    go mod edit -replace github.com/openzipkin/zipkin-go-opentracing=github.com/openzipkin-contrib/zipkin-go-opentracing@v0.4.0 && \
    go mod tidy

# Build ứng dụng
RUN CGO_ENABLED=0 GOOS=linux go build -o /catalogue ./cmd/cataloguesvc/main.go

FROM alpine:3.18
WORKDIR /app
COPY --from=builder /catalogue .
COPY --from=builder /app/images/ ./images/
RUN adduser -D appuser
USER appuser
ENTRYPOINT ["./catalogue"]
CMD ["-port=80"]
