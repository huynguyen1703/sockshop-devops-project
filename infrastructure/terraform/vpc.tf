module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = var.vpc_name
  cidr = "10.0.0.0/16"

  # Triển khai trên 3 Availability Zones để đảm bảo High Availability (HA)
  azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true # Dùng 1 NAT để tiết kiệm chi phí đồ án

  # TAGS CỰC KỲ QUAN TRỌNG: Để EKS tự động nhận diện Subnet khi tạo Load Balancer
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/sockshop-cluster" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/sockshop-cluster" = "shared"
  }
}
