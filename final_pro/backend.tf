terraform {
  backend "s3" {
    bucket = "wba-mybucket"
    key    = "logs/terraform.tfstate"
    region = "us-east-1"
  }
}