resource "aws_lb" "this" {
  name                       = var.nlb_name
  internal                   = false
  load_balancer_type         = "network"
  subnets                    = var.subnets
  enable_deletion_protection = false

  tags = {
    environment = var.environment

  }

}

resource "aws_lb_target_group" "this" {
  name     = var.TG_name
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "this" {
  count            = var.environment == "Prodcution" ? 3 : 2
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = element(var.private_servers, count.index)
  port             = 80
}
