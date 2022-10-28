# Security groups

# Public security groups
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

  dynamic "ingress" {
    for_each = aws_subnet.public_subnet_concurso
    content {
      description = "Access SSH from Internet"
      from_port   = 22
      to_port     = 22
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
    Name = "concurso-private-sg"
  }
}
