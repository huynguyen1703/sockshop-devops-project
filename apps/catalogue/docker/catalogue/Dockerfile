# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
FROM golang:1.25-alpine AS builder

ENV GOTOOLCHAIN=local

WORKDIR /go/src/github.com/microservices-demo/catalogue
COPY . .

RUN rm -rf vendor

RUN go mod init github.com/microservices-demo/catalogue || true

# 🎯 BẢN VÁ TỐI THƯỢNG: Mapping tên cũ sang repo mới nhất
RUN go mod edit -replace github.com/openzipkin/zipkin-go-opentracing=github.com/openzipkin-contrib/zipkin-go-opentracing@v0.5.0

RUN go mod tidy -mod=mod || true

RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -a -installsuffix cgo -o /app ./cmd/cataloguesvc