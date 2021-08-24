provider "aws" {
    profile = "default"
    region = "us-east-1"
}

resource "aws_s3_bucket" "tf_s3_course" {
  bucket = "terraform-bucket-vaibhav"
  acl = "private"
}