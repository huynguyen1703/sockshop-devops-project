# 1. Định nghĩa danh sách các microservices của Sock Shop
locals {
  services = [
    "front-end",
    "catalogue",
    "orders",
    "carts",
    "user",
    "payment",
    "shipping"
  ]
}

# 2. Tạo repository cho từng service
resource "aws_ecr_repository" "sockshop_repos" {
  for_each             = toset(local.services)
  name                 = "sockshop/${each.key}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true # Tự động quét lỗ hổng bảo mật khi Member B push image lên
  }

  force_delete = true # Cho phép xóa repo kể cả khi đang có image (tiện cho đồ án)
}

# 3. Xuất ra danh sách URL để gửi cho Thành viên B
output "ecr_repository_urls" {
  value = { for k, v in aws_ecr_repository.sockshop_repos : k => v.repository_url }
}
