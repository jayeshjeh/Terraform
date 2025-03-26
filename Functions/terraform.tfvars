aws_region         = "us-east-1"
vpc_cidr           = "172.18.0.0/16"
vpc_name           = "DevSecOps-VPC"
key_name           = "us"
azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_cidr_block  = ["172.18.1.0/24", "172.18.2.0/24", "172.18.3.0/24"]
private_cidr_block = ["172.18.10.0/24", "172.18.20.0/24", "172.18.30.0/24"]
environment        = "dev"
keyname            = "us"
ingress_ports      = ["80", "443", "22", "3389", "8080", "8443", "1900", "1443"]
amis = {
  us-east-1 = "ami-084568db4383264d4"
  us-east-2 = "ami-04f167a56786e4b09"
}