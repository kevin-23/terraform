# Variables from others modules
variable "vpcid" {
  description = "Vpc id from network module"
  type        = string
  nullable    = false
}

variable "public_subnet" {
  description = "Public subnet id from network module"
  type        = list(any)
  nullable    = false
}

variable "private_subnet" {
  description = "Private subnet id from network module"
  type        = string
  nullable    = false
}

# EC2 instance variables
variable "instance_ami" {
  description = "Instance AMI"
  type        = string
  nullable    = false
  default     = "ami-09d3b3274b6c5d4aa" #Amzn Linux 2
}

variable "instance_type" {
  description = "Instance types"
  type        = string
  nullable    = false
  default     = "t2.micro"
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
  default     = "kevinLabs"
}
