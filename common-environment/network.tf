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
  subnet_id     = aws_subnet.public_subnet_concurso[0].id
  allocation_id = aws_eip.eip_nat_concurso.id

  tags = {
    Name = "nat-gateway-concurso"
  }
}

resource "aws_subnet" "public_subnet_concurso" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc_concurso.id
  cidr_block              = "10.3.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.public_subnet_concurso)
  subnet_id      = aws_subnet.public_subnet_concurso[count.index].id
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
  vpc_id            = aws_vpc.vpc_concurso.id
  cidr_block        = var.private_subnet_cird
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = var.private_subnet_name
  }
}

resource "aws_route_table_association" "private_rt_association" {
  subnet_id      = aws_subnet.private_subnet_concurso.id
  route_table_id = aws_route_table.private_rt_concurso.id
}

# Application Load Balancer
resource "aws_lb_target_group" "tg_concurso" {
  name     = "tg-nginx-concurso"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_concurso.id
}

resource "aws_lb_target_group_attachment" "tg__attachtment_concurso" {
  count            = length(aws_instance.private_nginx_concurso)
  target_group_arn = aws_lb_target_group.tg_concurso.arn
  target_id        = aws_instance.private_nginx_concurso[count.index].id
  port             = 80
}

resource "aws_lb" "alb_concurso" {
  name               = "alb-nginx-concurso"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.concurso_public_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnet_concurso : subnet.id]

  enable_deletion_protection = false

  tags = {
    Name = "alb-nginx-concurso"
  }
}

resource "aws_lb_listener" "alb_listener_concurso" {
  load_balancer_arn = aws_lb.alb_concurso.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_concurso.arn
  }
}
