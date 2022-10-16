module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "tf-week19-vpc"
  cidr   = var.cidr_block

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "tf-week19-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_cp" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name

  capacity_providers = ["FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE_SPOT"
  }
}

module "ecs-fargate" {
  source              = "cn-terraform/ecs-fargate/aws"
  version             = "2.0.47"
  container_image     = var.image
  container_name      = "centos_container"
  name_prefix         = "tf-week19-ecs"
  private_subnets_ids = module.vpc.private_subnets
  public_subnets_ids  = module.vpc.public_subnets
  vpc_id              = module.vpc.vpc_id
}