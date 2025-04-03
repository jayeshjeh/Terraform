resource "aws_security_group" "this" {
    vpc_id = aws_vpc.this.id
    name = "${var.vpc_name}-SG"

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.vpc_name}-SG"
    }
}