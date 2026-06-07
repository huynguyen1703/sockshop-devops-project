# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
FROM golang:1.25-alpine AS builder

ENV GOTOOLCHAIN=local

WORKDIR /go/src/github.com/microservices-demo/catalogue
COPY . .

RUN rm -rf vendor

RUN go mod init github.com/microservices-demo/catalogue || true

# 🎯 BẢN VÁ 1: Mapping Zipkin sang repo mới (Đã chạy tốt)
RUN go mod edit -replace github.com/openzipkin/zipkin-go-opentracing=github.com/openzipkin-contrib/zipkin-go-opentracing@v0.5.0

# 🎯 BẢN VÁ 2: Ép go-kit về v0.5.0 để fix lỗi sai cấu trúc hàm NewServer
RUN go mod edit -replace github.com/go-kit/kit=github.com/go-kit/kit@v0.5.0

# Sửa lại lệnh tidy (bỏ cờ -mod=mod bị lỗi)
RUN go mod tidy || true

RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -a -installsuffix cgo -o /app ./cmd/cataloguesvc