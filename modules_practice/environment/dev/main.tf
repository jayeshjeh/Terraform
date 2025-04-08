provider "aws" {
    region = "sa-east-1"
}

terraform {
    backend "s3" {
        bucket = "spaceship007"
        key = "dev/terraform.tfstate"
        region = "sa-east-1"
    }
}

module "vpc" {
    
    source = "../../modules/vpc"
    cidr_block = var.vpc_cidr
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
    env = "dev"

}

module "sg" {
    source = "../../modules/sg"
    vpc_id = module.vpc.vpc_id
    ingress_ports = [22, 80, 443]
    env = "dev"

}

module "public_instance" {
    source = "../../modules/instances"
    env = "dev"
    ami = var.ami
    instance_type = var.instance_type
    subnet_ids = module.vpc.public_subnet_ids
    sg_id = module.sg.sg_id
    user_data = file("${path.module}/../../scripts/public_script.sh")
}

module "private_instances" {
  source = "../../modules/instances"

    env = "dev"
    ami = var.ami
    instance_type = var.instance_type
    subnet_ids = module.vpc.public_subnet_ids
    sg_id = module.sg.sg_id
    
}