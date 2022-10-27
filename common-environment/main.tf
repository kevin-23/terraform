# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["/home/kevin/.aws/confing"]
  shared_credentials_files = ["/home/kevin/.aws/credentials"]
  profile                  = "default"
}