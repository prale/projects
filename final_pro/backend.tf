terraform {
  backend "s3" {
    bucket = "wba-mybucket"
    key    = "logs/terrraform.tfstate"
    region = "us-east-1"
  }
}