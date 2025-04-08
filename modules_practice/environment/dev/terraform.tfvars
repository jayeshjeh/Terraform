vpc_cidr = "10.0.0.0/16"
public_subnets = [
  {
    cidr = "10.0.1.0/24", az = "sa-east-1a"
    cidr = "10.0.2.0/24", az = "sa-east-2a"
    cidr = "10.0.3.0/24", az = "sa-east-3a"
  }
]

private_subnets = [
  {
    cidr = "10.0.4.0/24", az = "sa-east-1a"
    cidr = "10.0.5.0/24", az = "sa-east-2a"
    cidr = "10.0.6.0/24", az = "sa-east-3a"
  }
]

ami = "ami-0d866da98d63e2b42"
instance_type = "t2.micro"
