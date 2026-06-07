# ==========================================
# STAGE 1: Xây dựng (Builder)
# ==========================================
# Nâng cấp lên Node 18-alpine để vá các lỗ hổng bảo mật hệ điều hành cũ
FROM node:18-alpine AS builder

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

# ==========================================
# STAGE 2: Chạy thực tế (Production)
# ==========================================
FROM node:18-alpine

ENV NODE_ENV="production"
ENV PORT=8079
EXPOSE 8079

# Tạo user không có quyền root (Alpine/Node bản mới có sẵn user 'node', 
# nhưng giữ cấu hình tạo user tùy biến của bạn vẫn chạy rất tốt)
RUN addgroup mygroup && \
    adduser -D -G mygroup myuser && \
    mkdir -p /usr/src/app && \
    chown -R myuser:mygroup /usr/src/app

WORKDIR /usr/src/app

# Copy toàn bộ thành phẩm với quyền của myuser
COPY --from=builder --chown=myuser:mygroup /usr/src/app .

USER myuser

CMD ["npm", "start"]