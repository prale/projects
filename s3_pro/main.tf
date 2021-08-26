# Use AWS Terraform provider
provider "aws" {
  region = "us-east-1"
}

# Create s3 bucket
resource "aws_s3_bucket" "c" {
  bucket = var.bucket_name
  //acl    = "private"
  tags = {
    Owner       = "Vaibhav"
    Environment = "Dev"
  }
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "c" {
  bucket = aws_s3_bucket.c.id

  block_public_acls   = true
  block_public_policy = true
}

resource "aws_s3_bucket_policy" "c" {
  bucket = aws_s3_bucket.c.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.c.arn,
          "${aws_s3_bucket.c.arn}/*",
        ]
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "8.8.8.8/32"
          }
        }
      },
    ]
  })
}

resource "aws_s3_access_point" "c" {
  bucket = aws_s3_bucket.c.id
  name   = "{aws_s3_bucket.c.id}access_point"
}
