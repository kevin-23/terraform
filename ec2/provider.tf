provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      environment = "production"
      owner       = "kevin.cabezas"
      tool        = "terraform"
    }
  }
}