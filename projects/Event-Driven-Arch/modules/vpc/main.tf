resource "aws_vpc" "this" {
    cidr_block = var.cidr_block

    tags = {
      Name = "${var.env}-vpc"
    }
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this

    tags = {
      Name = "${var.env}-IGW"
    }
}

resource "aws_subnet" "public" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.this.id
    cidr_block = var.public_subnets[count.index].cidr
    availability_zone = var.public_subnets[count.index].azs
    map_public_ip_on_launch = true

    tags = {
      Name = "${var.env}-public-subnet-${count.index +1}"
    }
}

resource "aws_subnet" "private" {
    count = length(var.private_subnets)
    vpc_id = aws_vpc.this.id
    cidr_block = var.private_subnets[count.index].cidr
    availability_zone = var.private_subnets[count.index].azs

    tags = {
      Name = "${var.env}-private-subnet-${count.index + 1}"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id
    }

    tags = {
      Name = "${var.env}-public-RT"
    }
  
}

resource "aws_route_table_association" "this" {
    count = length(aws_subnets.public)
    subnet_id = aws_subnet.public[count.index.id]
    route_table_id = aws_route_table.public.id 
}
