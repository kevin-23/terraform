output "vpc_id" {
  description = "Displays the VPC id"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Displays the id of the public subnets"
  value       = module.subnets.public_ids
}