output "vpcid" {
  value       = aws_vpc.vpc_main.id
  description = "VPC id"
}

output "public_subnet" {
  value       = aws_subnet.public_subnet
  description = "Publc subnet id"
}

output "private_subnet" {
  value       = aws_subnet.private_subnet.id
  description = "Id of the private subnets"
}
