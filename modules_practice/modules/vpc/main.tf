resource "aws_vpc" "this" {
    cidr_block = var.cidr_block
    tags = {
      Name = "${var.env}-vPc"
    }
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id

    tags = {
      Name = "${var.env}-iGw"
    }
}

resource "aws_subnet" "public" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.this.id
    cidr_block = var.public_subnets[count.index].cidr
    availability_zone = var.public_subnets[count.index].az
    tags = {
        Name = "${var.env}-public-subnet-${count.index + 1}"
    }
  
}

resource "aws_subent" "private" {
    count = length(var.private_subnets)
    vpc_id = aws_vpc.this.id
    cidr_block = var.private_subnets[count.index].cidr
    availability_zone = var.private_subents[count.index].az
    tags = {
        Name = "${var.env}-private-subnet-${count.index + 1}"
    }
}

resource "aws_eip" "this" {
    domain = "vpc"
  
}

resource "aws_nat_gateway" "this" {

    allocation_id = aws_eip.this.id
    subnet_id = aws_subnet.public[0].id 

    tags = {
        Name = "$var.env"-nAt
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

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.this.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.this.id
    }

    tags = {
        Name = "${var.env}-private-RT"
    }
  
}

resource "aws_route_table_association" "public" {
    count = length(var.public_subnets)
    subnet_id = aws_subnet_public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
    count = length(var.private_subnets)
    subnet_id = aws_subnet_private[count.index].id
    route_table_id = aws_route_table.private.id
  
}
