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
  public_subnets  = module.subnets.public_ids
}
