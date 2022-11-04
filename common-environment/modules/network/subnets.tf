resource "aws_subnet" "public_0" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.3.${count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-tf-${count.index + 1}"
  }
}

resource "aws_subnet" "private_0" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.3.${count.index + 2}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private-subnet-tf-${count.index + 1}"
  }
}
