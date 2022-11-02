# Creates EC2 instances
resource "aws_instance" "bastion_concurso" {
  count                  = 1
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = "kevinLabs"
  subnet_id              = aws_subnet.public_subnet_concurso[0].id
  vpc_security_group_ids = [aws_security_group.concurso_public_sg.id]
  tags = {
    Name = "bastion-concurso"
  }
  lifecycle {
    ignore_changes = [
      ebs_block_device
    ]
  }
}

resource "aws_instance" "private_nginx_concurso" {
  count                  = 2
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = "kevinLabs"
  subnet_id              = aws_subnet.private_subnet_concurso.id
  vpc_security_group_ids = [aws_security_group.concurso_private_sg.id]
  user_data              = <<EOF
  #!/bin/bash
  sudo yum update -y
  sudo amazon-linux-extras install nginx1 -y 
  sudo systemctl enable nginx 
  sudo systemctl start nginx
  EOF

  tags = {
    Name = "${var.instance_name_2}-${count.index + 1}"
  }
  lifecycle {
    ignore_changes = [
      ebs_block_device
    ]
  }
}
