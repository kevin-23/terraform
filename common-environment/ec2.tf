# Creates EC2 instances

resource "aws_instance" "web" {
  count                  = 2
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = "kevinLabs"
  subnet_id              = aws_subnet.public_subnet_concurso.id
  vpc_security_group_ids = [aws_security_group.concurso_public_sg.id]
  tags = {
    Name = "public-concurso"
  }
  lifecycle {
    ignore_changes = [
      ebs_block_device
    ]
  }
}
