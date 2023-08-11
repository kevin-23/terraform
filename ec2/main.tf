resource "aws_instance" "jenkins" {
  ami                         = var.instance_ami
  key_name                    = var.key_name
  subnet_id                   = local.public_subnet_ids[0]
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.public.id]
  associate_public_ip_address = true
  tags = {
    "Name" = var.resource_name
  }
  lifecycle {
    ignore_changes = [
      ebs_block_device
    ]
  }
}