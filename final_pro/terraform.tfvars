//AWS Coount details
//access_key = AWS_ACCESS_KEY_ID
//secret_key = AWS_SECRET_ACCESS_KEY
aws_account = "807875358668"
aws_region = "us-east-1"

//Vendor details
vendor_name = "vaibhavdmore"
vendor_user_role_arn = "arn:aws:iam::807875358668:user/prale"
vendor_vpc_id = "vpc-99365ae4"
read = false
write = false
read_write = false

//key configuration
key_description = "#PLEASE DO NOT USE THIS KEY. THIS KEY WILL BE DELETED AFTER COMPLETING TESTING# This is a narrow single use case S3 default encryption key for the S3 bucket shared with our vendor. They use the key to access encrypted data drops to said S3 bucket as an Operational DataLake."
key_administrators = ["arn:aws:iam::807875358668:user/prale","arn:aws:iam::807875358668:user/vaibhav"]

//Bucket configuration
acl = "private"
versioning = true
sse_algorithm = "aws:kms"
tags  = {
        "Environment" = "Production",
        "Owner"   = "SwarmAnalytics",
        "Project" = "SwarmAnalytics"
    }
block_public_acls = true
block_public_policy = true
ignore_public_acls = true
restrict_public_buckets = true
