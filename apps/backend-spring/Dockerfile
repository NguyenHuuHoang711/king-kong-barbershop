# --- Stage 1: Build mã nguồn bằng Maven ---
FROM maven:3.9.6-eclipse-temurin-17-alpine AS builder
WORKDIR /app

# Copy file cấu hình pom.xml trước để tận dụng Docker Cache cho dependencies
COPY pom.xml .
RUN mvn friendship-go-offline || mvn dependency:go-offline

# Copy toàn bộ mã nguồn và build ra file .jar
COPY src ./src
RUN mvn clean package -DskipTests

# --- Stage 2: Tạo Runtime Image siêu nhẹ ---
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Tạo một user unprivileged để chạy app (Chuẩn bảo mật Enterprise, không chạy bằng root)
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copy file .jar đã build từ Stage 1 sang
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

# Cấu hình tối ưu bộ nhớ RAM cho môi trường Container On-Prem
ENTRYPOINT ["java", "-XX:+UseG1GC", "-XX:+UseContainerSupport", "-jar", "app.jar"]