# Public subnet variables
variable "public_subnet_name" {
  description = "Name of the public subnet concurso"
  default     = "public-concurso"
}

# EC2 instance variables
variable "instance_ami" {
  description = "Instance AMI"
  default     = "ami-09d3b3274b6c5d4aa"
}

variable "instance_type" {
  description = "Instance types"
  default     = "t2.micro"
}

variable "instance_name_2" {
  description = "Instance name"
  default     = "nginx-concurso"
}
