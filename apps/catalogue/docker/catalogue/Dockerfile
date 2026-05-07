# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
FROM golang:1.21-alpine AS builder

# Thiết lập thư mục làm việc chuẩn theo cấu trúc của Go cũ
WORKDIR /go/src/github.com/microservices-demo/catalogue
COPY . .

# Chuyển đổi sang hệ thống quản lý thư viện hiện đại (Go Modules) thay cho gvt
RUN go mod init github.com/microservices-demo/catalogue || true
RUN go mod tidy || true

# Biên dịch mã nguồn thành file nhị phân độc lập tại thư mục /app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /app ./cmd/cataloguesvc

# ==========================================
# STAGE 2: Chạy thực tế (Production)
# ==========================================
# Sử dụng Alpine bản mới (3.19) để vượt qua bài kiểm tra bảo mật của Trivy
FROM alpine:3.19

# Thiết lập các biến môi trường cho user
ENV SERVICE_USER=myuser \
    SERVICE_UID=10001 \
    SERVICE_GROUP=mygroup \
    SERVICE_GID=10001

# Tạo group và user không có quyền root (Non-root user)
RUN addgroup -g ${SERVICE_GID} ${SERVICE_GROUP} && \
    adduser -g "Catalogue user" -D -H -G ${SERVICE_GROUP} -s /sbin/nologin -u ${SERVICE_UID} ${SERVICE_USER}

WORKDIR /

# Copy file thực thi và thư mục ảnh từ STAGE 1
COPY --from=builder /app /app
COPY --from=builder /go/src/github.com/microservices-demo/catalogue/images/ /images/

# Cấp quyền thực thi và đổi quyền sở hữu cho user vừa tạo
RUN chmod +x /app && \
    chown -R ${SERVICE_USER}:${SERVICE_GROUP} /app /images

# Chuyển sang user thường
USER ${SERVICE_USER}

# Mở đúng port 8080 theo chuẩn của dịch vụ catalogue
EXPOSE 8080
CMD ["/app", "-port=8080"]