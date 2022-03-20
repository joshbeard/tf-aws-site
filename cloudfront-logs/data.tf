data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_s3_bucket" "logging" {
  bucket = var.log_bucket
}
