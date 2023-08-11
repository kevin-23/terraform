output "public_ids" {
  description = "Displays the id of the public subnets"
  value       = aws_subnet.public[*].id
}
