resource "aws_instance" "private" {
  count                  = var.environment == "Production" ? 3 : 2
  ami                    = lookup(var.amis, var.aws_region)
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = element(var.private_subnet_ids, count.index)
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name        = "${var.vpc_name}-private-server-${count.index + 1}"
    environment = var.environment

  }
}