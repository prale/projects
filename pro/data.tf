//kMS key policy document
/*data "aws_iam_policy_document" "key" {
  statement {
    sid = "Allow KMS Use"
    effect = "Allow"
    actions = "kms:*"
    resources = "*"
    principal = {"AWS": "arn:aws:iam::${var.AWS_ACCOUNT_ID}:root"}
    }
  }
*/