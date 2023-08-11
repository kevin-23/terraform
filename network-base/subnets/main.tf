resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = var.vpc_id
  cidr_block        = "10.10.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.availableaz.names[count.index]

  tags = {
    Name = "${var.public_subnet_name}-${count.index}"
  }
}