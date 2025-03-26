provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "spaceship970"
    key    = "Development.tfstate"
    region = "us-east-1"

  }
}

