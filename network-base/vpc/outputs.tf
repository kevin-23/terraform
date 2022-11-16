###########################
### VPC OUTPUTS ###
###########################
output "id" {
  description = "Displays the VPC id"
  value       = aws_vpc.main.id
}
