resource "aws_instance" "private-servers" {
  count                  = var.environment == "prod" ? 3 : 1
  ami                    = lookup(var.amis, var.aws_region)
  instance_type          = "t2.micro"
  key_name               = var.keyname
  subnet_id              = element(var.private_subnet_ids, count.index)
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name        = "${var.vpc_name}-private-server-${count.index + 1}"
    environment = "${var.environment}"
  }


}