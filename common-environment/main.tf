# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["/home/kevin/.aws/confing"]
  shared_credentials_files = ["/home/kevin/.aws/credentials"]
  profile                  = "default"
}

# Modules
module "network" {
  source = "./modules/network"
}

module "ec2" {
  source         = "./modules/ec2"
  vpcid          = module.network.vpcid
  public_subnet  = module.network.public_subnet
  private_subnet = module.network.private_subnet
}
