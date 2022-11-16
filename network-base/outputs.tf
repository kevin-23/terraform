###########################
### MODULE OUTPUTS ###
###########################
output "vpc_id" {
  description = "Displays the VPC id"
  value       = module.vpc.id
}

output "public_subnet_ids" {
  description = "Displays the id of the public subnets"
  value       = module.subnets.public_ids
}
