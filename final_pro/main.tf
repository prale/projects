// KMS-Key Creation
resource "aws_kms_key" "key" {
  description         = var.key_description
  // All other options are default
  tags = var.tags
  policy = data.aws_iam_policy_document.kms_policy.json
}

resource "aws_kms_alias" "key" {
  target_key_id = aws_kms_key.key.key_id
  name          = "alias/wbplay-${var.vendor_name}-test-key"
}

//Bucket Creation
resource "aws_s3_bucket" "b" {
    bucket = "wbplay-${var.vendor_name}-test"
    acl    = var.acl
    tags = var.tags
    policy = data.aws_iam_policy_document.bucket_policy.json
    versioning {
        enabled = var.versioning
    }

// S3 bucket encryption
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "arn:aws:kms:${var.aws_region}:${var.aws_account}:key/${aws_kms_key.key.key_id}"
        sse_algorithm     = var.sse_algorithm
      }
    }
  }
}

// S3 bucket prefixes
resource "aws_s3_bucket_object" "folder1" {
    bucket = aws_s3_bucket.b.id
    acl    = var.acl
    key    = "${var.vendor_name}-to-wba/"
    server_side_encryption = var.sse_algorithm
}
resource "aws_s3_bucket_object" "folder2" {
    bucket = aws_s3_bucket.b.id
    acl    = var.acl
    key    = "wba-to-${var.vendor_name}/"
    server_side_encryption = var.sse_algorithm
}

// S3 Block Public Access
resource "aws_s3_bucket_public_access_block" "b" {
    bucket = aws_s3_bucket.b.id
    block_public_acls = var.block_public_acls
    block_public_policy = var.block_public_policy
    ignore_public_acls = var.ignore_public_acls
    restrict_public_buckets = var.restrict_public_buckets
}

// S3 bucket access point 
resource "aws_s3_access_point" "b" {
  bucket = aws_s3_bucket.b.id
  name   = "wbplay-${var.vendor_name}-test-access-point"
  policy = data.aws_iam_policy_document.access_point_policy.json
  vpc_configuration {
    vpc_id = var.vendor_vpc_id 
    }
}

// Analytical  bucket creation
resource "aws_s3_bucket" "a" {
    count = var.analytic_bucket ? 1 : 0
    bucket = "wbplay-${var.vendor_name}"
    acl    = var.acl
    tags = var.tags
    //policy = data.aws_iam_policy_document.bucket_policy.json
    versioning {
        enabled = var.versioning
    }

// S3 bucket encryption
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "arn:aws:kms:${var.aws_region}:${var.aws_account}:key/${aws_kms_key.key.key_id}"
        sse_algorithm     = var.sse_algorithm
      }
    }
  }
}

// S3 bucket prefixes
resource "aws_s3_bucket_object" "folder3" {
    bucket = aws_s3_bucket.a[count.index]
    acl    = var.acl
    key    = "${var.vendor_name}-to-wba/"
    server_side_encryption = var.sse_algorithm
}
resource "aws_s3_bucket_object" "folder4" {
    bucket = aws_s3_bucket.a[count.index]
    acl    = var.acl
    key    = "wba-to-${var.vendor_name}/"
    server_side_encryption = var.sse_algorithm
}
/*
// S3 Block Public Access
resource "aws_s3_bucket_public_access_block" "a" {
    count = var.analytic_bucket ? 1 : 0
    block_public_acls = var.block_public_acls
    block_public_policy = var.block_public_policy
    ignore_public_acls = var.ignore_public_acls
    restrict_public_buckets = var.restrict_public_buckets
}
*/
