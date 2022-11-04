resource "aws_lb" "alb" {
  name               = "alb-nginx-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = [for subnet in var.public_subnet : subnet.id]

  enable_deletion_protection = false

  tags = {
    Name = "alb-nginx-tf"
  }
}

resource "aws_lb_target_group" "tg_nginx" {
  name     = "tg-nginx-tf"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpcid
}

resource "aws_lb_target_group_attachment" "tg_attachtment" {
  count            = length(aws_instance.private_nginx)
  target_group_arn = aws_lb_target_group.tg_nginx.arn
  target_id        = aws_instance.private_nginx[count.index].id
  port             = 80
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_nginx.arn
  }
}
