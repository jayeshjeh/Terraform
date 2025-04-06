output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnets_ids" {
  value = aws_subnet.private[*].id

}

output "sg_id" {
  value = aws_security_group.this.id
}

output "igw_id" {
  value = aws_internet_gateway.this.id

}

output "nat_id" {
  value = aws_nat_gateway.this.id

}

