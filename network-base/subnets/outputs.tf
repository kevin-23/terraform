###########################
### SUBNET OUTPUTS ###
###########################
output "public_ids" {
  description = "Displays the id of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_ids" {
  description = "Displays the id of the private subnets"
  value       = aws_subnet.private[*].id
}

output "nat_id" {
  description = "Displays the id of the NAT Gateway"
  value       = aws_nat_gateway.public_gw.id
}
