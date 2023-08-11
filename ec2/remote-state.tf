data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    region = "us-east-1"
    bucket = "k3v-terraform-states"
    key    = "network/main"
  }
}