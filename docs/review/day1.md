# 1. Xây dựng kiến trúc tổng thể

📁 KingKongBarberShop/ (Thư mục gốc)
├── 📄 mise.toml -----------> [Quản lý Version tập trung: Node 20, Java 17, Terraform 1.5.7]
├── 📄 docker-compose.yml --> [Điều phối chạy thử đồng thời cả Frontend & Backend ở Local]
├── 📄 .gitignore ----------> [Tấm khiên bảo mật: Chặn leak rác node_modules, target, secrets]
├── 📁 apps/
│ ├── 📁 frontend-nextjs/ -> [Mã nguồn NextJS Frontend - Chạy trên Port 3000]
│ └── 📁 backend-spring/ -> [Mã nguồn Spring Boot API Core - Chạy trên Port 8080]
└── 📁 terraform/ ----------> [Hạ tầng Git đã cấu hình qua GitHub Provider]

# 2. Bài học & Khái niệm

Bản chất của Git Branch Protection và Scopes

- Kiến thức: Github Free giới hạn tính năng chặn nhánh trên Repo private. Muốn chạy api Terraform, token phải có scopes read:org và read:discussion do cơ chế kiểm tra nghiêm ngặt của GraphQL
- Tư duy: Không dùng git push -f trên các nhánh (dev/staging/main). Học cách xử lý git pull origin dev --rebase để gộp lịch sử Git thẳng tắp chuẩn nghiệp vụ team

# Cô lập môi trường dự án với mise(Modern Tooling)

- Kiến thức: thay thế hoàn toàn cho các công cụ cũ như nvm, sdkman,tfenv. Dùng file mise.toml để phân chia theo môi trường:
  -e dev: Java, Node, pnpm cho lập trình viên ứng dụng
  -e devops: Terraform, Kubectl, Ansible cho kỹ sư hệ thống
- Ý nghĩa: Tránh việc mò mẫm cài đặt phiên bản khi chuyển đổi hệ điều hành hoặc khi onboarding người mới

# Đóng gói đa tầng (Multi-stage Build) & Tách biệt Dockefile
