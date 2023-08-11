resource "aws_security_group" "public" {
  name        = var.resource_name
  description = "Allow SSH and HTTP traffic from the Internet"
  vpc_id      = local.vpc_id

  ingress {
    description = "Access SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # remember to update the block
  }

  ingress {
    description = "Access HTTP from Internet"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # remember to update the block
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.resource_name
  }
}