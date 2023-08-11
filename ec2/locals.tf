locals {
  public_subnet_ids = data.terraform_remote_state.network.outputs.public_subnet_ids
  vpc_id            = data.terraform_remote_state.network.outputs.vpc_id
}