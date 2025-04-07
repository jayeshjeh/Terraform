resource "aws_instance" "public" {
  count                       = var.env == "prod" ? 3 : 2
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(var.public_subent_ids, count.index % length(var.public_subent_ids))
  vpc_security_group_ids      = var.sg_id
  user_data                   = var.user_data
  associate_public_ip_address = true
  availability_zone           = element(var.azs, count.index % length(var.azs))

  tags = {
    Name = "${var.env}-public-{count.index + 1}"
  }
}

resource "aws_instance" "private" {
  count                  = var.env == "prod" ? 3 : 2
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = element(var.private_subent_ids, count.index % length(var.private_subent_ids))
  vpc_security_group_ids = var.sg_id
  availability_zone      = element(var.azs, count.index % length(var.azs))
  user_data              = var.user_data

  tags = {
    Name = "${var.env}-private-{count.index + 1}"
  }

}