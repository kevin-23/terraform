# Configure the AWS Provider
# Keys are environment variables
provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      environment = "test"
      owner       = "kevin.cabezas"
      tool        = "terraform"
    }
  }
}

module "vpc" {
  source = "./vpc"
}

module "subnets" {
  source = "./subnets"
  vpc_id = module.vpc.id
}
