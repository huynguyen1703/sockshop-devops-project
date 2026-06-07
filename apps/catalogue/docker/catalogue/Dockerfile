# ==========================================
# STAGE 1: Xây dựng (Builder) - Sử dụng Go 1.16 cổ điển
# ==========================================
FROM golang:1.16-alpine AS builder

# 🎯 CHIẾN THUẬT: Tắt Go Modules, quay về cơ chế GOPATH + Vendor truyền thống
ENV GO111MODULE=off
ENV CGO_ENABLED=0
ENV GOOS=linux

WORKDIR /go/src/github.com/microservices-demo/catalogue

# Sao chép toàn bộ mã nguồn vào (GIỮ NGUYÊN VENDOR GỐC, KHÔNG XÓA)
COPY . .

# Biên dịch trực tiếp từ vendor có sẵn, không tải mới từ Internet, không lo lệch API
RUN go build -a -installsuffix cgo -o /app ./cmd/cataloguesvc