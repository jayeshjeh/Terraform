resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id
    }

    tags = {
      Name = "${var.vpc_name}-public-RT"
      Owner = local.owner
      CostCenter = local.cost_center
      TeamDL = local.team_dl
      environment = "${var.environment}"
    }
}


resource "aws_route_table" "private" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_internet_gateway.this.id
    }

    tags = {
      Name = "${var.vpc_name}-private-RT"
      Owner = local.owner
      CostCenter = local.cost_center
      TeamDL = local.team_dl
      environment = "${var.environment}"
    }
}

resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public[*].id)
    subnet_id = element(aws_subnet.public[*].id, count.index)
    route_table_id = aws_route_table.public
  
}


resource "aws_route_table_association" "private" {
    count = length(aws_subnet.private[*].id)
    subnet_id = element(aws_subnet.private[*].id, count.index)
    route_table_id = aws_route_table.private.id  
}

