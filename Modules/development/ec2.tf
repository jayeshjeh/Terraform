module "dev_ec2_1" {
    source = "../../Modules/modules/COMPUTE/"
    environment = module.dev_vpc_1.environment
    amis = {
        us-east-1 = "ami-084568db4383264d4"
    }
    aws_region = var.aws_region
    keyname = "us"
    vpc_name = module.dev_vpc_1.vpc_name
    sg_id = module.dev_sg_1.sg_id
    public_subnet_ids = module.dev_vpc_1.public_subnet_ids
    private_subnet_ids = module.dev_vpc_1.private_subnet_ids
}