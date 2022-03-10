locals {
  bucket_name     = var.bucket_name != null var.bucket_name : "s3-website-${var.domain}"
  log_bucket_name = var.log_bucket_name != null var.log_bucket_name : "${local.bucket_name}-logs"
  tags            = merge(var.tags, { "domain" = "${var.domain}" })
}
