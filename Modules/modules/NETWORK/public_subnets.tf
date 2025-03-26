resource "aws_subnet" "public-subnets" {
  count = length(var.public_cidr_block)
  # count             = 3
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public_cidr_block, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name        = "${var.vpc_name}-public-subnet-${count.index + 1}"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }
}