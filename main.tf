module "image" {
  source   = "./image"
  image_in = var.image
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "tf-week19-vpc"
  cidr = var.cidr_block

  azs             = var.availability_zones
  private_subnets = var.private_sbn_cidr_ranges
  public_subnets  = var.public_sbn_cidr_ranges


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# module "network" {
#   source                     = "./network"
#   name                       = var.vpc_name
#   cidr_block_in              = var.cidr_block
#   availability_zones_in      = var.availability_zones
#   public_sbn_cidr_ranges_in  = var.public_sbn_cidr_ranges
#   private_sbn_cidr_ranges_in = var.private_sbn_cidr_ranges
# }

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "tf-week19-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_cp" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

# module "ecs-fargate" {
#   source  = "cn-terraform/ecs-fargate/aws"
#   version = "2.0.47"
#   container_image = module.image.image_out
#   container_name = "centos_container"
#   name_prefix = "tf-week19-ecs"

# }