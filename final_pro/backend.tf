terraform {
  backend "s3" {
    bucket = "wba-mybucket"
    key    = "logs/wbplay-${var.vendor_name}-test.tfstate"
    region = "us-east-1"
  }
}