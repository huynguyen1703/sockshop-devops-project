FROM node:18-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8075
# Front-end của Sock Shop chạy ở cổng 8075
CMD ["npm", "start"]
