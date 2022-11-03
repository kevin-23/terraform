# Public subnet variables
variable "public_subnet_name" {
  description = "Name of the public subnets"
  type        = string
  default     = "public-subnet-tf"
}

# EC2 instance variables
variable "instance_ami" {
  description = "Instance AMI"
  type        = string
  nullable    = false
}

variable "instance_type" {
  description = "Instance types"
  type        = string
  nullable    = false
}

variable "instance_name_2" {
  description = "Instance name"
  type        = string
  default     = "nginx-instance-tf"
}

variable "key_name" {
  description = "Access key to instances"
  type        = string
  nullable    = false
}
