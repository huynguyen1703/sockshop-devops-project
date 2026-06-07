# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
FROM golang:1.21-alpine AS builder

WORKDIR /go/src/github.com/microservices-demo/catalogue
COPY . .

# XÓA THƯ MỤC VENDOR CŨ ĐỂ TRÁNH XUNG ĐỘT (Bản vá chí mạng)
RUN rm -rf vendor

# Khởi tạo go module
RUN go mod init github.com/microservices-demo/catalogue || true
RUN go mod tidy || true

# Biên dịch mã nguồn (Thêm cờ -mod=mod để ép buộc compiler dùng Go Modules)
RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -a -installsuffix cgo -o /app ./cmd/cataloguesvc