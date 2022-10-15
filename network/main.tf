# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block_in
  tags = {
    Name = "tf-week19-vpc"
  }
}

# Create VPC Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Internet_Gateway"
  }
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# Create private subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_sbn_cidr_ranges_in)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_sbn_cidr_ranges_in, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private-sbn-${count.index + 1}"
    Tier = "Private"
  }
}