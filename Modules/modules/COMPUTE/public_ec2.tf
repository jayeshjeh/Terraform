resource "aws_instance" "public-servers" {
  # count                       = length(var.public_cidr_block)
  count                       = var.environment == "prod" ? 3 : 1
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = "t2.micro"
  key_name                    = var.keyname
  subnet_id                   = element(var.public_subnet_ids, count.index)
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true

  tags = {
    Name        = "${var.vpc_name}-public-server-${count.index + 1}"
    environment = "${var.environment}"
  }
  user_data = <<-EOF
              #!/bin/bash
            sudo apt update
            sudo apt install nginx -y
            echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
            sudo systemctl start nginx
            sudo systemctl enable nginx
            
            EOF
}