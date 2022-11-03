# Creates EC2 instances
resource "aws_instance" "bastion" {
  count                  = 1
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public_subnet[0].id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  tags = {
    Name = "bastion-tf"
  }
  lifecycle {
    ignore_changes = [
      ebs_block_device
    ]
  }
}

resource "aws_instance" "private_nginx" {
  count                  = 2
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
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
