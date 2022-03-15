# ------------------------------------------------------------------------------
# Local variables
# ------------------------------------------------------------------------------
locals {
  hyphen_domain_name = replace(var.domain, ".", "-")

  bucket_name     = var.bucket_name != null ? var.bucket_name : "s3-website-${local.hyphen_domain_name}"
  log_bucket_name = var.log_bucket_name != null ? var.log_bucket_name : "${local.bucket_name}-logs"
  iam_name        = var.iam_name != null ? var.iam_name : "s3-deployer-${local.hyphen_domain_name}"
  tags            = merge(var.tags, { "domain" = var.domain, "_created_by" = "terraform" })
}
