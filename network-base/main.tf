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
  vpc_id = module.vpc.vpc_id
}

module "routes" {
  source          = "./routes"
  vpc_id          = module.vpc.vpc_id
  igw_id          = module.vpc.igw_id
  nat_id          = module.subnets.nat_id
  public_subnets  = module.subnets.public_ids
  private_subnets = module.subnets.private_ids
}
