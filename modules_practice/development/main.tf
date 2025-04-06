provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "spaceship970"
    key    = "dev.tfstate"
    region = "us-east-1"
  }
}

module "network" {
  source      = "/../modules/network/"
  cidr_block  = var.vpc_cidr
  vpc_id      = module.vpc_id
  vpc_name    = var.vpc_name
  environment = var.environment

  public_subnets  = module.public_subnets_ids
  private_subnets = module.private_subnets_ids
}

module "compute" {
  source                      = "../../modules/compute/"
  environment                 = var.environment
  ami                         = lookup(var.amis, var.aws_region)
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_id                      = module.vpc_id
  public_subnets_ids          = element(module.public_subnets_ids, count.index)
  security_group_id           = module.sg_id
  associate_public_ip_address = true
  igw_id = module.igw_id
  nat_id = module.nat_id
  sg_id  = module.sg_id
  tags = {
    Name = "${var.vpc_name}-public-server"
  }

  depends_on = [var.elb_listener.this.id]
}

module "nat" {
  source      = "../../modules/nat/"
  environment = var.environment
  subnet_id   = element(module.public_subnets_ids[0], count.index)
  nat_id = module.nat_id
}

module "sg" {
  source      = "../../modules/sg/"
  environment = var.environment
  vpc_id      = module.vpc_id
  sg_id = module.sg_id
}