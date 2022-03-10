# ------------------------------------------------------------------------------
# Provider Configuration
#
# An 'aws' provider aliased 'cert' is defined here for the ACM resources to
# ensure they are deployed to the proper region.
# ------------------------------------------------------------------------------
provider "aws" {
  region  = "us-west-2"
}

# Certificates use the 'us-east-1' region.
provider "aws" {
  region  = "us-east-1"
  alias   = "cert"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0.0"
}