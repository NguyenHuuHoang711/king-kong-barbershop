FROM node:20-alpine
WORKDIR /app

# Cài đặt pnpm toàn cục bên trong container
RUN npm install -g pnpm

# Chỉ copy các file package để tận dụng bộ nhớ cache của Docker
COPY package.json pnpm-lock.yaml* ./

# Cài đặt TẤT CẢ các dependencies (bao gồm cả devDependencies phục vụ hot-reload)
RUN pnpm install

# Khai báo biến môi trường cho chế độ lập trình
ENV NODE_ENV=development
ENV NEXT_TELEMETRY_DISABLED=1

# Cổng mặc định của NextJS dev server
EXPOSE 3000

# Chạy lệnh dev server quét file liên tục
CMD ["pnpm", "dev"]