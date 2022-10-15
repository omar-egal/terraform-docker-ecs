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

# Create a route to the internet
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Create association for public route
resource "aws_route_table_association" "public_sbn_association" {
  count          = length(var.public_sbn_cidr_ranges_in)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_route.id
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# Create public subnets
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_sbn_cidr_ranges_in)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.public_sbn_cidr_ranges_in, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "public-sbn-${count.index + 1}"
    Tier = "Public"
  }
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