variable "instance_ami" {
  description = "Instance AMI"
  type        = string
  default     = "ami-09d3b3274b6c5d4aa"
}

variable "instance_type" {
  description = "Instance types"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Access key to instances"
  type        = string
  default     = "kevinLabs"
}

variable "resource_name" {
  description = "Resource name for EC2 instance"
  type        = string
  default     = "jenkins-production"
}