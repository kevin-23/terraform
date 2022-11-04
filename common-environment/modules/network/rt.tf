resource "aws_default_route_table" "main_route_table" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main-rt-tf"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(aws_subnet.public_0)
  subnet_id      = aws_subnet.public_0[count.index].id
  route_table_id = aws_default_route_table.main_route_table.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-rt-tf"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = length(aws_subnet.private_0)
  subnet_id      = aws_subnet.private_0[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
