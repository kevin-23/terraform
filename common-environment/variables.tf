# VPC variables
variable "vpc_cird" {
  description = "CIRD of the VPC concurso"
  default     = "10.3.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC concurso"
  default     = "vpc-concurso"
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  default     = "igw-concurso"
}

# Public subnet variables
variable "public_subnet_cird" {
  description = "CIRD of the public subnet of concurso"
  default     = "10.3.2.0/24"
}

variable "public_subnet_name" {
  description = "Name of the public subnet concurso"
  default     = "public-concurso"
}

# Private subnet variables
variable "private_rt_name" {
  description = "Name of the private route table"
  default     = "private-rt-concurso"
}

variable "private_subnet_cird" {
  description = "CIRD of the private subnet of concurso"
  default     = "10.3.3.0/24"
}

variable "private_subnet_name" {
  description = "Name of the private subnet concurso"
  default     = "private-concurso"
}

# EC2 instance variables
variable "instance_ami" {
  description = "Instance AMI"
  default     = "ami-09d3b3274b6c5d4aa"
}

variable "instance_type" {
  description = "Instance types"
  default     = "t3.micro"
}

variable "instance_name_1" {
  description = "Instance name"
  default     = "campaing-concurso"
}

variable "instance_name_2" {
  description = "Instance name"
  default     = "mongodb-concurso"
}

variable "instance_name_3" {
  description = "Instance name"
  default     = "bastion-concurso"
}
