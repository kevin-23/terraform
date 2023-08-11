output "vpc_id" {
  description = "Displays the VPC id"
  value       = aws_vpc.main.id
}

output "igw_id" {
  description = "Displays the IGW id"
  value       = aws_internet_gateway.igw.id
}
