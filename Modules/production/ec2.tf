module "prod" {
    source = "../../Modules/modules/COMPUTE/"
    environment = module.prod_vpc_1.environment
    amis = {
        us-east-1 = "ami-084568db4383264d4"
    }
    aws_region = var.aws_region
    keyname = "us"
    vpc_name = module.prod_vpc_1.vpc_name
    sg_id = module.prod_sg_1.sg_id
    public_subnet_ids = module.prod_vpc_1.public_subnet_ids
    private_subnet_ids = module.prod_vpc_1.private_subnet_ids
}