resource "aws_security_group" "public_sg" {
  name        = "public-sg-tf"
  description = "Allow SSH and HTTP traffic from the Internet"
  vpc_id      = var.vpcid

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
    Name = "public-sg-tf"
  }
}

resource "aws_security_group" "private_sg" {
  name        = "private-sg-tf"
  description = "Allow SSH and HTTP traffic from the public subnets"
  vpc_id      = var.vpcid

  dynamic "ingress" {
    for_each = var.public_subnet
    content {
      description = "Access SSH from public subnets"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr_block]
    }
  }

  dynamic "ingress" {
    for_each = var.public_subnet
    content {
      description = "Access HTTP from the public subnets"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [ingress.value.cidr_block]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg-tf"
  }
}
