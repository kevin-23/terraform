# Creates the AWS network components

# VPC and its components
resource "aws_vpc" "vpc_main" {
  cidr_block       = "10.3.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-main-tf"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "igw-tf"
  }
}

resource "aws_default_route_table" "main_route_table" {
  default_route_table_id = aws_vpc.vpc_main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main-rt-tf"
  }
}

# Public subents and its components
resource "aws_eip" "eip_nat" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  depends_on    = [aws_internet_gateway.igw, aws_eip.eip_nat]
  subnet_id     = aws_subnet.public_subnet[0].id
  allocation_id = aws_eip.eip_nat.id

  tags = {
    Name = "nat-gateway-tf"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc_main.id
  cidr_block              = "10.3.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.public_subnet_name}-${count.index + 1}"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_default_route_table.main_route_table.id
}

# Private subents and its components
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt-tf"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = "10.3.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "private-subnet-tf"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# Application Load Balancer
resource "aws_lb_target_group" "tg_nginx" {
  name     = "tg-nginx-tf"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_main.id
}

resource "aws_lb_target_group_attachment" "tg_attachtment" {
  count            = length(aws_instance.private_nginx)
  target_group_arn = aws_lb_target_group.tg_nginx.arn
  target_id        = aws_instance.private_nginx[count.index].id
  port             = 80
}

resource "aws_lb" "alb" {
  name               = "alb-nginx-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnet : subnet.id]

  enable_deletion_protection = false

  tags = {
    Name = "alb-nginx-tf"
  }
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
