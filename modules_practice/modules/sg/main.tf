resource "aws_security_group" "this" {
  vpc_id = var.vpc_id
  name   = "${var.env}-SG"

  dynamic "ingress" {

    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "${var.env}-sG"
  }
}