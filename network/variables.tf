variable "name" {
  description = "The VPC name"
}

variable "cidr_block_in" {
  description = "The VPC CIDR block range"
}

variable "availability_zones_in" {
  description = "The AZs"
}

variable "public_sbn_cidr_ranges_in" {
  description = "The private subnet CIDR block ranges"
}

variable "private_sbn_cidr_ranges_in" {
  description = "The private subnet CIDR block ranges"
}