terraform {
  backend "s3" {
    encrypt = true
    acl = "private"
  }
}