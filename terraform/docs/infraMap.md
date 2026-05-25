Nhánh Git Môi trường Hạ tầng (Proxmox LXC/VM)
─────────── ────────────────────────────────────
feature/\* ──────> (Chạy, test local trên Docker máy cá nhân)
│ (Pull Request / Review)
▼
dev ──────> Môi trường DEV (Cụm LXC mã nguồn mở, tài nguyên thấp, DB test)
│ (Pull Request / Release Stage)
▼
staging ──────> Môi trường STAGING (Bản sao giống 99% Production, test tải/gRPC)
│ (Tag Release / Hotfix)
▼
main ──────> Môi trường PRODUCTION (Hạ tầng HA - High Availability, Security cao)
