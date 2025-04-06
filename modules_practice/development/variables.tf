variable "aws_region" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "environment" {}
variable "key_name" {}
variable "instance_type" {}
variable "amis" {
  type = map(string)
  default = {
    us-east-1 = "ami-084568db4383264d4"
    us-east-2 = "ami-04f167a56786e4b09"
  }
}
variable "public_subnets_cidr_blocks" {}
variable "private_subnets_cidr_blocks" {}
variable "azs" {}
variable "nlb_name" {}
variable "TG_name" {}
