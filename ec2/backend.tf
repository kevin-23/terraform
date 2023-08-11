terraform {
  backend "s3" {
    bucket = "k3v-terraform-states"
    key    = "ec2/jenkins"
    region = "us-east-1"
  }
}