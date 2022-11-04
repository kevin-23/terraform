output "vpcid" {
  value       = aws_vpc.main.id
  description = "VPC id"
}

output "public_subnet" {
  value       = aws_subnet.public_0
  description = "Publc subnet id"
}

output "private_subnet" {
  value       = aws_subnet.private_0
  description = "Id of the private subnets"
}
