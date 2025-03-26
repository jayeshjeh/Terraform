resource "aws_instance" "public-servers" {
  # count                       = length(var.public_cidr_block)
  count                       = var.environment == "prod" ? 3 : 1
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = "t2.micro"
  key_name                    = var.keyname
  subnet_id                   = element(aws_subnet.public-subnets.*.id, count.index + 1)
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true

  tags = {
    Name        = "${var.vpc_name}-public-server-${count.index + 1}"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }



}
