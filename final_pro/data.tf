// S3 Bucket Policy
data "aws_iam_policy_document" "bucket_policy" {

    statement {
            sid = "Delegate all actions to S3 access point policies"
            effect = "Allow"
            actions = ["s3:*"]
            resources = [
                "arn:aws:s3:::wbplay-${var.vendor_name}-test",
                "arn:aws:s3:::wbplay-${var.vendor_name}-test/*"
            ]
            principals {
                    type = "AWS"
                    identifiers = ["*"]
                }

            condition {
                test = "ArnLike"
                variable = "s3:DataAccessPointArn"
                values = [
                    "arn:aws:s3:${var.aws_region}:${var.aws_account}:accesspoint/*"
                ]
                }
        }
}    

// S3 bucket access point policy
data "aws_iam_policy_document" "access_point_policy" {

    statement {
            sid = "List bucket Access"
            effect = "Allow"
            principals {
                    type = "AWS"
                    identifiers = ["${var.vendor_user_role_arn}"]
            }
            actions = ["s3:ListBucket*"]
            resources = [ 
                "arn:aws:s3:${var.aws_region}:${var.aws_account}:accesspoint/wbplay-${var.vendor_name}-test-access-point"
            ]
        }
    
    dynamic "statement" {
        for_each = var.read ? ["allow_read"] : []
            content {
            sid = "Read Access"
            effect = "Allow"
            principals {
                    type = "AWS"
                    identifiers = ["${var.vendor_user_role_arn}"]
            }
            actions = ["s3:get*"]
            resources = [
                "arn:aws:s3:${var.aws_region}:${var.aws_account}:accesspoint/wbplay-${var.vendor_name}-test-access-point/object/*"
            ]
        }
    }

    dynamic "statement" {
        for_each = var.write ? ["allow_write"] : []
            content {
            sid = "Write Access"
            effect = "Allow"
            principals {
                    type = "AWS"
                    identifiers = ["${var.vendor_user_role_arn}"]
            }
            actions = ["s3:put*"]
            resources = [
                "arn:aws:s3:${var.aws_region}:${var.aws_account}:accesspoint/wbplay-${var.vendor_name}-test-access-point/object/*"
            ]
        }
    }

    dynamic "statement" {
        for_each = var.read_write ? ["allow_read_write"] : []
            content {
            sid = "Read and Write Access"
            effect = "Allow"
            principals {
                    type = "AWS"
                    identifiers = ["${var.vendor_user_role_arn}"]
            }
            actions = [
                "s3:get*",
                "s3:put*"
                ]
            resources = [
                "arn:aws:s3:${var.aws_region}:${var.aws_account}:accesspoint/wbplay-${var.vendor_name}-test-access-point/object/*"
            ]
        }
    }
}

// KMS key
data "aws_iam_policy_document" "kms_policy" {

    statement {
            sid = "Enable IAM User Permissions"
            effect = "Allow"
            principals {
                type = "AWS"
                identifiers = ["arn:aws:iam::${var.aws_account}:root"]
            }
            actions = ["kms:*"]
            resources = ["*"]
        }

    statement {    
            sid = "Explicit Deny to all principals."
            effect = "Deny"
            principals {
                type = "AWS"
                identifiers = ["*"]
            }
            actions = ["kms:Delete*"]
            resources = ["*"]
        }

    statement {
            sid = "Allow access for Key Administrators"
            effect = "Allow"
            principals {
                type = "AWS"
                identifiers = [
                "${var.key_administrators[0]}",
                "${var.key_administrators[1]}"
                ]
               }
            actions = [
                "kms:Create*",
                "kms:Describe*",
                "kms:Enable*",
                "kms:List*",
                "kms:Put*",
                "kms:Update*",
                "kms:Revoke*",
                "kms:Disable*",
                "kms:Get*",
                "kms:Delete*",
                "kms:TagResource",
                "kms:UntagResource"
            ]
            resources = ["*"]
        }

    statement {
            sid = "Allow key use for encrypt/decrypt"
            effect = "Allow"
            principals {
                type = "AWS"
                identifiers = ["${var.vendor_user_role_arn}"]
            }
            actions = [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*"
            ]
            resources = ["*"]
        }

    statement {
            sid = "Allow attachment of persistent resources"
            effect = "Allow"
            principals {
                type = "AWS"
                identifiers = [
                "${var.key_administrators[0]}",
                "${var.key_administrators[1]}"
                ]
            }
            actions = [
                "kms:CreateGrant",
                "kms:ListGrants",
                "kms:RevokeGrant"
            ]
            resources = ["*"]
            condition {
                test = "Bool"
                variable = "kms:GrantIsForAWSResource"
                values = [
                    "true"
                ]
            }
        }
}