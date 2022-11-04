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

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_main.id
  cidr_block        = "10.3.3.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "private-subnet-tf"
  }
}
