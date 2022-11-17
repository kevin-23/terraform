###########################
### INPUT VARIABLES ###
###########################
variable "vpc_id" {
  description = "Gets the VPC id"
}

variable "igw_id" {
  description = "Gets the Internet Gateway id"
}

variable "nat_id" {
  description = "Gets the NAT Gateway id"
}

variable "public_subnets" {
  description = "Gets the id of the public subnets"
}

variable "private_subnets" {
  description = "Gets the id of the private subnets"
}
