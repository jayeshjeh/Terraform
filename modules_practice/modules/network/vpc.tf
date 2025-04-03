resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true

    tags = {
        Name = "${var.vpc_name}"
        Owner = local.owner
        TeamDL = local.team_dl
        cost_center = local.cost_center
        environment = var.environment
    }
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id

    tags = {
        Name = "${var.vpc_name}-igw"
        Owner = local.owner
        TeamDL = local.team_dl
        cost_center = local.cost_center
        environment = var.environment
    }
  
}