# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
FROM node:10-alpine AS builder

WORKDIR /usr/src/app

# Copy các file quản lý thư viện trước
COPY package.json yarn.lock ./

# Cài đặt thư viện bằng yarn (giữ nguyên công cụ của tác giả gốc)
RUN yarn install

# Copy toàn bộ mã nguồn vào
COPY . .

# ==========================================
# STAGE 2: Chạy thực tế (Production)
# ==========================================
FROM node:10-alpine

# Set các biến môi trường
ENV NODE_ENV="production"
ENV PORT=8079
EXPOSE 8079

# Tạo user không có quyền root và thư mục làm việc (chuẩn bảo mật)
RUN addgroup mygroup && \
    adduser -D -G mygroup myuser && \
    mkdir -p /usr/src/app && \
    chown -R myuser:mygroup /usr/src/app

WORKDIR /usr/src/app

# Copy TOÀN BỘ source code và thư viện đã cài từ STAGE 1 sang STAGE 2
# Dùng flag --chown để cấp quyền sở hữu luôn cho myuser, tránh lỗi permission denied
COPY --from=builder --chown=myuser:mygroup /usr/src/app .

# Chuyển sang user thường để chạy app
USER myuser

# Khởi chạy ứng dụng
CMD ["npm", "start"]