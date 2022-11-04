# VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.3.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-main-tf"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "igw-tf"
  }
}

resource "aws_nat_gateway" "nat" {
  depends_on    = [aws_eip.eip_nat]
  subnet_id     = aws_subnet.public_0[0].id
  allocation_id = aws_eip.eip_nat.id

  tags = {
    Name = "nat-gateway-tf"
  }
}

resource "aws_eip" "eip_nat" {
  vpc = true
}
