#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "spaceship970"
    key    = "functions.tfstate"
    region = "us-east-1"

  }

}

resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.vpc_name}"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name        = "${var.vpc_name}-IGW"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }
}

resource "aws_subnet" "public-subnets" {
  count = length(var.public_cidr_block)
  # count             = 3
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.public_cidr_block, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name        = "${var.vpc_name}-public-subnet-${count.index + 1}"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }

}

resource "aws_subnet" "private-subnets" {
  count             = length(var.private_cidr_block)
  vpc_id            = aws_vpc.default.id
  cidr_block        = element(var.private_cidr_block, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name        = "${var.vpc_name}-private-subnet-${count.index + 1}"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }
}

resource "aws_route_table" "public-RT" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name        = "${var.vpc_name}-public-RT"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }
}

resource "aws_route_table" "private-RT" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name        = "${var.vpc_name}-private-RT"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }

}


resource "aws_route_table_association" "public-subnet-RT-association" {
  count          = length(aws_subnet.public-subnets[*].id)
  subnet_id      = element(aws_subnet.public-subnets[*].id, count.index)
  route_table_id = aws_route_table.public-RT.id

}

resource "aws_route_table_association" "private-subnet-RT-association" {
  count          = length(aws_subnet.private-subnets[*].id)
  subnet_id      = element(aws_subnet.private-subnets[*].id, count.index)
  route_table_id = aws_route_table.private-RT.id

}

resource "aws_security_group" "allow_all" {
  name        = "${var.vpc_name}-SG"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.default.id

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
    Name        = "${var.vpc_name}-SG"
    Owner       = local.Owner
    CostCenter  = local.CostCenter
    TeamDL      = local.TeamDL
    environment = "${var.environment}"
  }
}

# data "aws_ami" "my_ami" {
#      most_recent      = true
#      #name_regex       = "^sai"
#      owners           = ["232323232323232323"]
# }




# resource "aws_dynamodb_table" "state_locking" {
#   hash_key = "LockID"
#   name     = "dynamodb-state-locking"
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
#   billing_mode = "PAY_PER_REQUEST"
# }

##output "ami_id" {
#  value = "${data.aws_ami.my_ami.id}"
#}
#!/bin/bash
# echo "Listing the files in the repo."
# ls -al
# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
# echo "Running Packer Now...!!"
# packer build -var=aws_access_key=AAAAAAAAAAAAAAAAAA -var=aws_secret_key=BBBBBBBBBBBBB packer.json
# echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++"
# echo "Running Terraform Now...!!"
# terraform init
# terraform apply --var-file terraform.tfvars -var="aws_access_key=AAAAAAAAAAAAAAAAAA" -var="aws_secret_key=BBBBBBBBBBBBB" --auto-approve
