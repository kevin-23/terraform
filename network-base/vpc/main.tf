resource "aws_vpc" "main" {
  cidr_block = var.vpc_cird

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-test-tf"
  }
}