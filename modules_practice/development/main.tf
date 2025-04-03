provider "aws" {
	region = var.aws_region
}

terraform {
	backend "s3" {
	bucket = "spaceship970"
	key = "dev.tfstate"
	region = "us-east-1"
	}
}

module "vpc" {
	source = "../../modules/network"
	cidr_block = var.vpc_cidr
	vpc_id = module.vpc_id

	public_subnets = module.public_subnets_ids
	private_subnets = module.private_subnets_ids
	
	igw_id = module.igw_id
	nat_id = module.nat_id
	sg_id = module.sg_id
}