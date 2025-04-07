resource "aws_security_group" "this" {
  vpc_id = var.vpc_id
  name   = "${var.env}-SG"

  dynamic "ingress" {

    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingreess.value
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }

  }

  dynamic "egress" {

    for_each = var.egress_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }

  }

  tags = {
    name = "${var.env}-sG"
  }
}