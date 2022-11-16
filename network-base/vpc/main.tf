resource "aws_vpc" "main" {
  cidr_block = var.vpc_cird

  tags = {
    Name = var.vpc_name
  }
}
