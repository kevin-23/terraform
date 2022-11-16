###########################
### INPUT VARIABLES ###
###########################
variable "vpc_id" {
  description = "Gets the VPC id"
}

###########################
### SUBNET VARIABLES ###
###########################
variable "public_subnet_name" {
  description = "Defines the names of the public subnets"
  default     = "public-test-tf"
}

variable "private_subnet_name" {
  description = "Defines the names of the private subnets"
  default     = "private-test-tf"
}
