# Use AWS Terraform provider
provider "aws" {
  region = "us-east-1"
}

# Create s3 bucket
resource "aws_s3_bucket" "tf_aws_s3" {
  bucket = var.bucket_name
  acl = "private"
}