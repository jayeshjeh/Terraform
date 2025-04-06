resource "aws_eip" "this" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
    allocation_id = aws_eip.this.id
    subnet_id = var.public_subnets_ids[0].id

    tags = {
        Name = "${var.vpc_name}-NAT"
    }
}

