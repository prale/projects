//AWS Coount details
variable "access_key" {
    type        = string
    description = "(Required) AWS Access Key"
    default = ""
}
variable "secret_key" {
    type        = string
    description = "(Required) AWS Secret Key"
    default = ""
}
variable "aws_account" {
    type        = string
    description = "(Required) AWS Account Number"
    default = "807875358668"
}
variable "aws_region" {
    type        = string
    description = "(Required) AWS region"
    default = "us-east-1"
}

//Vendor details
variable "vendor_name" {
    type        = string
    description = "(Required) Creates a unique bucket name beginning with the specified prefix."
    default = "null"
}
variable "vendor_user_role_arn" {
    type        = string
    description = "(Required) The user/role from vendor account that wll have the permissions"
    default = "null"
}
variable "vendor_vpc_id" {
    type        = string
    description = "(Required) VPC ID of the Vendor's VPC to use in access point Network origin"
    default = "null"
}
variable "read" {
  type        = bool
  description = "Allow reading of the bucket"
  default     = false
}
variable "write" {
  type        = bool
  description = "Allow writing in the bucket"
  default     = false
}
variable "read_write" {
  type        = bool
  description = "Allow read and write in the bucket"
  default     = true
}

//key configuration
variable "key_description" {
    type        = string
    description = "(Required) Description of the bucket"
    default = "#PLEASE DO NOT USE THIS KEY. THIS KEY WILL BE DELETED AFTER COMPLETING TESTING# This is a narrow single use case S3 default encryption key for the S3 bucket shared with our vendor. They use the key to access encrypted data drops to said S3 bucket as an Operational DataLake."
}
variable "key_administrators" {
    type        = list
    description = "(Required) Description of the bucket"
    default = ["arn:aws:iam::807875358668:user/prale","arn:aws:iam::807875358668:user/vaibhav"]
}

//Bucket configuration
variable "acl" {
    type        = string
    description = "(Required) The canned ACL to apply. Defaults to private. Conflicts with grant."
    default = "private"
}
variable "versioning" {
    type        = bool
    description = "(Required) A state of versioning."
    default = true
}
variable "block_public_acls" {
    type        = bool
    description = "(Required) block_public_acls"
    default = true
}
variable "block_public_policy" {
    type        = bool
    description = "(Required) block_public_policy"
    default = true
}
variable "ignore_public_acls" {
    type        = bool
    description = "(Required) ignore_public_acls"
    default = true
}
variable "restrict_public_buckets" {
    type        = bool
    description = "(Required) restrict_public_buckets"
    default = true
}
variable "sse_algorithm" {
    type        = string
    description = "(Required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
    default = "aws:kms"
}
variable "tags" {
    type        = map
    description = "(Required) A mapping of tags to assign to the bucket."
    default = {
        "Environment" = "Production",
        "Owner"   = "SwarmAnalytics",
        "Project" = "SwarmAnalytics"
    }
}
