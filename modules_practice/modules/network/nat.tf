resource "aws_eip" "this" {
    domain = "vpc"
  
}

resource "aws_nat_gateway" "this" {
    
    allocation_id = aws_eip.this.id
    subnet_id = aws_subnet.public[0].id

    tags = {
      Name = "${var.vpc_name}-NAT"
    }

}