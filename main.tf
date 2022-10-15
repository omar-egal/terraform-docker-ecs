module "image" {
  source   = "./image"
  image_in = var.image
}

module "network" {
  source                     = "./network"
  name                       = var.vpc_name
  cidr_block_in              = var.cidr_block
  availability_zones_in      = var.availability_zones
  public_sbn_cidr_ranges_in = var.public_sbn_cidr_ranges
  private_sbn_cidr_ranges_in = var.private_sbn_cidr_ranges
}

module "ecs" {
  source = "./ecs"
}