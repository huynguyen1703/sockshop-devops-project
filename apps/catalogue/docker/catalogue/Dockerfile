# ==========================================
# STAGE 1: Xây dựng (Quay về kỷ nguyên GOPATH 2017)
# ==========================================
FROM golang:1.17-alpine AS builder

# Thiết lập GOPATH chuẩn mực của dự án cũ
ENV GOPATH=/go
WORKDIR /go/src/github.com/microservices-demo/catalogue

# Copy toàn bộ mã nguồn (BAO GỒM CẢ THƯ MỤC VENDOR NGUYÊN BẢN)
COPY . .

# 🎯 ĐIỂM CHỐT HẠ: Tắt hoàn toàn Go Modules
# Lệnh này ép Go phải sử dụng các thư viện chuẩn đã được chốt cứng 
# bên trong thư mục /vendor của dự án, bỏ qua mọi rà soát trên mạng.
ENV GO111MODULE=off

# Biên dịch ứng dụng tĩnh
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app ./cmd/cataloguesvc