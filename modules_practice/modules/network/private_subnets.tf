resource "aws_subnet" "private" {
    count = length(var.private_subnets_cidr_blocks)
    vpc_id = aws_vpc.this.id
    cidr_block = element(var.private_subnets_cidr_blocks, count.index)
    availability_zone = element(var.azs, count.index)
  
}