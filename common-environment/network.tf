# Creates the AWS network components

# VPC and its components
resource "aws_vpc" "vpc_concurso" {
  cidr_block       = var.vpc_cird
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw_concurso" {
  vpc_id = aws_vpc.vpc_concurso.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_default_route_table" "main_route_table" {
  default_route_table_id = aws_vpc.vpc_concurso.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_concurso.id
  }

  tags = {
    Name = "main-rt-concurso"
  }
}

# Public subents and its components
resource "aws_eip" "eip_nat_concurso" {
  vpc = true
}

resource "aws_nat_gateway" "nat_concurso" {
  depends_on    = [aws_internet_gateway.igw_concurso, aws_eip.eip_nat_concurso]
  subnet_id     = aws_subnet.public_subnet_concurso.id
  allocation_id = aws_eip.eip_nat_concurso.id

  tags = {
    Name = "nat-gateway-concurso"
  }
}

resource "aws_subnet" "public_subnet_concurso" {
  vpc_id                  = aws_vpc.vpc_concurso.id
  cidr_block              = var.public_subnet_cird
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet_concurso.id
  route_table_id = aws_default_route_table.main_route_table.id
}

# Private subents and its components
resource "aws_route_table" "private_rt_concurso" {
  vpc_id = aws_vpc.vpc_concurso.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_concurso.id
  }

  tags = {
    Name = "private-rt-concurso"
  }
}

resource "aws_subnet" "private_subnet_concurso" {
  vpc_id     = aws_vpc.vpc_concurso.id
  cidr_block = var.private_subnet_cird

  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_route_table_association" "private_rt_association" {
  subnet_id      = aws_subnet.private_subnet_concurso.id
  route_table_id = aws_route_table.private_rt_concurso.id
}

# Security groups
resource "aws_security_group" "concurso_public_sg" {
  name        = "concurso-public-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc_concurso.id

  ingress {
    description      = "Access SSH from Internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Access HTTP from Internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "concurso-public-sg"
  }
}

resource "aws_security_group" "concurso_private_sg" {
  name        = "concurso-private-sg"
  description = "Allow SSH outbound traffic"
  vpc_id      = aws_vpc.vpc_concurso.id

  ingress {
    description      = "Access SSH from Internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.public_subnet_cird]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "concurso-private-sg"
  }
}
