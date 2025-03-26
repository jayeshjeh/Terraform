module "dev_sg_1" {
  source        = "../modules/SG"
  vpc_name      = module.dev_vpc_1.vpc_name
  vpc_id        = module.dev_vpc_1.vpc_id
  ingress_ports = [22, 80, 443]
  environment   = module.dev_vpc_1.environment

}