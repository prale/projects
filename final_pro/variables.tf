//AWS Coount details
variable "access_key" {
    type        = string
    description = "(Required) AWS Access Key"
}
variable "secret_key" {
    type        = string
    description = "(Required) AWS Secret Key"
}
variable "aws_account" {
    type        = string
    description = "(Required) AWS Account Number"
}
variable "aws_region" {
    type        = string
    description = "(Required) AWS region"
}

//Vendor details
variable "vendor_name" {
    type        = string
    description = "(Required) Creates a unique bucket name beginning with the specified prefix."
}
variable "vendor_user_role_arn" {
    type        = string
    description = "(Required) The user/role from vendor account that wll have the permissions"
}
variable "vendor_vpc_id" {
    type        = string
    description = "(Required) VPC ID of the Vendor's VPC to use in access point Network origin"
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
  default     = false
}

//key configuration
variable "key_description" {
    type        = string
    description = "(Required) Description of the bucket"
}
variable "key_administrators" {
    type        = list
    description = "(Required) Description of the bucket"
}

//Bucket configuration
variable "acl" {
    type        = string
    description = "(Required) The canned ACL to apply. Defaults to private. Conflicts with grant."
}
variable "versioning" {
    type        = bool
    description = "(Required) A state of versioning."
}
variable "block_public_acls" {
    type        = bool
    description = "(Required) block_public_acls"
}
variable "block_public_policy" {
    type        = bool
    description = "(Required) block_public_policy"
}
variable "ignore_public_acls" {
    type        = bool
    description = "(Required) ignore_public_acls"
}
variable "restrict_public_buckets" {
    type        = bool
    description = "(Required) restrict_public_buckets"
}
variable "sse_algorithm" {
    type        = string
    description = "(Required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
}
variable "tags" {
    type        = map
    description = "(Required) A mapping of tags to assign to the bucket."
}
