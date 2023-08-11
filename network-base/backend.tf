terraform {
  backend "s3" {
    bucket = "k3v-terraform-states"
    key    = "network/base"
    region = "us-east-1"
  }
}