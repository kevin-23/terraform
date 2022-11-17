resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = var.vpc_id
  cidr_block        = "10.10.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.availableaz.names[count.index]

  tags = {
    Name = "${var.public_subnet_name}${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = var.vpc_id
  cidr_block        = "10.10.${count.index + 2}.0/24"
  availability_zone = data.aws_availability_zones.availableaz.names[count.index + 1]

  tags = {
    Name = "${var.private_subnet_name}${count.index}"
  }
}

resource "aws_nat_gateway" "public_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "nat-test-tf"
  }

  depends_on = [aws_eip.nat_eip]
}

resource "aws_eip" "nat_eip" {
  vpc = true
  tags = {
    Name = "nat-test-tf"
  }
  depends_on = [
    var.vpc_id
  ]
}
