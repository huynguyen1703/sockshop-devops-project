# Sử dụng Python 3.10 trên nền Alpine mới để vá sạch lỗ hổng OS
FROM python:3.10-alpine

WORKDIR /app

# Cài đặt các chứng chỉ mạng cần thiết
RUN apk add --no-cache ca-certificates curl

# Copy file cấu hình thư viện vào trước (nếu có requirements.txt)
# Hoặc nếu dự án chỉ dùng mỗi requests, ta có thể cài trực tiếp
COPY requirements.txt* /app/

# Nâng cấp pip và cài đặt thư viện không sinh cache thừa
RUN pip install --no-cache-dir --upgrade pip && \
    if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; else pip install --no-cache-dir requests; fi

# Copy toàn bộ mã nguồn của service payment vào
COPY . /app/

# Tạo user thường không có quyền root để chạy ứng dụng (Chuẩn DevSecOps)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup && \
    chown -R appuser:appgroup /app

# Chuyển sang user thường
USER appuser

# Khai báo port chạy thực tế của payment
EXPOSE 8080

# Lệnh khởi chạy ứng dụng chính
CMD ["python", "app.py"]