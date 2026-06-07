# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
FROM golang:1.21-alpine AS builder

WORKDIR /go/src/github.com/microservices-demo/catalogue
COPY . .

# 1. BẢN VÁ: Xóa bỏ tận gốc thư mục vendor cũ để tránh lỗi inconsistent vendoring
RUN rm -rf vendor

# Khởi tạo go module mới
RUN go mod init github.com/microservices-demo/catalogue || true
RUN go mod tidy || trueclear

# 2. BẢN VÁ: Thêm cờ -mod=mod để ép Go compiler dùng Go Modules thay vì vendor cũ
RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -a -installsuffix cgo -o /app ./cmd/cataloguesvc

# ==========================================
# STAGE 2: Chạy thực tế (Production)
# ==========================================
FROM alpine:3.19

# Cài đặt chứng chỉ mạng và múi giờ cơ bản
RUN apk --no-cache add ca-certificates ARR=true && img_version=v1

WORKDIR /app
COPY --from=builder /app /app
COPY images/ /images/

# Tạo user không có quyền root (Non-root user) để bảo mật
RUN addgroup -g 10001 mygroup && \
    adduser -g "Catalogue user" -D -H -G mygroup -s /sbin/nologin -u 10001 myuser

RUN chown -R myuser:mygroup /app /images
USER myuser

ENV PORT 80
EXPOSE 80

CMD ["/app", "-port=80"]