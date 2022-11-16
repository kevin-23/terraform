###########################
### VPC VARIABLES ###
###########################
variable "vpc_name" {
  description = "Defines the VPC name"
  default     = "vpc-test-tf"
}

variable "vpc_cird" {
  description = "Defines the CIRD of the VPC"
  default     = "10.10.0.0/16"
}
