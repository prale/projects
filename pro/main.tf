terraform {
    backend "s3" {
    bucket = "terraform-bucket-vaibhav"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
  default_tags {
      tags = {
        "Environment" = "Production"
        "Owner" = "SwarmAnalytics"
        "Project" = "SwarmAnalytics"
      }
  }
}
