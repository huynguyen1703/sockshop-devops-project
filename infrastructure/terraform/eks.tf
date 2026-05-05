# 1. Khai báo Module EKS
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "sockshop-cluster"
  cluster_version = "1.30" # Phiên bản Kubernetes mới và ổn định

  # Cho phép truy cập công cộng vào Endpoint của Cluster (để bạn dùng kubectl từ máy nhà)
  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets # Chạy worker nodes trong vùng Private cho bảo mật

  # 2. Cấu hình Worker Nodes (Nơi chạy các Pod ứng dụng)
  eks_managed_node_groups = {
    sockshop_nodes = {
      min_size     = 2
      max_size     = 3 # Giảm bớt để tiết kiệm
      desired_size = 2 # 2 node là đủ để chạy thử ban đầu

      # Thay đổi instance type sang t3.small (2 vCPU, 2GB RAM) cho rẻ hơn t3.medium
      instance_types = ["t3.small"]
      
      # Dùng SPOT để tránh lỗi kiểm tra Free Tier và tiết kiệm chi phí
      capacity_type  = "SPOT" 
    }
  }
  # 3. Cấp quyền quản trị cho chính bạn (người tạo cluster)
  enable_cluster_creator_admin_permissions = true

  tags = {
    Environment = "dev"
    Project     = "sockshop"
  }
}
