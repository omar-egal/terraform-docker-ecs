output "vpc_id_out" {
  value = aws_vpc.vpc.id
}


output "private_sbn_cidr_ranges" {
  value = aws_subnet.private_subnets[*].id
}