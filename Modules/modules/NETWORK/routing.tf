resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name        = "${var.vpc_name}-public-RT"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }
}

resource "aws_route_table" "private-RT" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name        = "${var.vpc_name}-private-RT"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }

}

resource "aws_route_table_association" "public-subnet-RT-association" {
  count          = length(aws_subnet.public-subnets[*].id)
  subnet_id      = element(aws_subnet.public-subnets[*].id, count.index)
  route_table_id = aws_route_table.public-RT.id

}

resource "aws_route_table_association" "private-subnet-RT-association" {
  count          = length(aws_subnet.private-subnets[*].id)
  subnet_id      = element(aws_subnet.private-subnets[*].id, count.index)
  route_table_id = aws_route_table.private-RT.id

}