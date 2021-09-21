terraform {
  backend "s3" {
    bucket = "wba-mybucket"
    key    = "logs/${var.vendor_name}/terrraform.tfstate"
    region = "us-east-1"
  }
}