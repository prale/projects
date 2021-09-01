//KMS key creation
/*
resource "aws_kms_key" "key" {
  description             = "KMS key 1"
  deletion_window_in_days = 10
}
resource "aws_kms_alias" "key" {
  name          = "alias/wba-${var.VENDOR_NAME}-vendor-key"
  target_key_id = aws_kms_key.key.key_id
}
*/
//Bucket Creation
resource "aws_s3_bucket" "bucket" {
  bucket = "wba-${var.VENDOR_NAME}-vendor"
  acl    = "private"
  tags = {
    Owner       = "Vaibhav"
    Environment = "Dev"
  }
  versioning {
    enabled = true
  }
}