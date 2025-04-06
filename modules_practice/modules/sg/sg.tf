locals {
    ports_in = [22, 80, 443]
    ports_out = [22,80, 443]
}

resource "aws_security_group" "this" {
    name = "${var.vpc_name}-allow-all"
    vpc_id = var.vpc_id

    dynamic "ingress" {
      for_each = toset(local.ports_in)
      content {
        from_port = ingress.value
        to_port = ingress.value 
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }

    dynamic "egress" {
      for_each = toset(local.ports_out)
      content {
        from_port = egress.value
        to_port = egress.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    }

    tags = {
      Name = "${var.vpc_name}-allow-all"
      environment = var.environment
    }
}
