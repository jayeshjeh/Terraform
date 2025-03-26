resource "aws_instance" "private-servers" {
  count                  = length(var.private_cidr_block)
  ami                    = lookup(var.amis, var.aws_region)
  instance_type          = "t2.micro"
  key_name               = var.keyname
  subnet_id              = element(aws_subnet.private-subnets.*.id, count.index + 1)
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  tags = {
    Name        = "${var.vpc_name}-private-server-${count.index + 1}"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }

  user_data = <<-EOF
     #!/bin/bash
     	sudo apt-get update
     	sudo apt-get install -y nginx
     	echo "<h1>${var.environment}-Server-1</h1>" | sudo tee /var/www/html/index.html
        echo "<h1>${var.vpc_name}-private-server-${count.index + 1}</h1>" | sudo tee /var/www/html/index.html
     	sudo systemctl start nginx
     	sudo systemctl enable nginx
     EOF

}
