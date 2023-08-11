terraform {
  backend "s3" {
    bucket = "k3v-terraform-states"
    key    = "network/main"
    region = "us-east-1"
  }
}