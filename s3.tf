# ------------------------------------------------------------------------------
# S3 website bucket
# ------------------------------------------------------------------------------
resource "aws_s3_bucket" "site" {
  bucket = local.bucket_name

  tags = merge(local.tags, { "Name" = "${local.bucket_name}" })
}

resource "aws_s3_bucket_acl" "site" {
  bucket = aws_s3_bucket.site.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_cors_configuration" "site" {
  bucket = aws_s3_bucket.site.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["https://${var.domain}"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_logging" "site" {
  bucket = aws_s3_bucket.site.id

  target_bucket = aws_s3_bucket.site_logs.id
  target_prefix = var.log_prefix != null ? var.log_prefix : var.domain
}

# Log bucket
resource "aws_s3_bucket" "site_logs" {
  bucket        = local.log_bucket_name
  force_destroy = true
  tags          = merge(local.tags, { "Name" = "${local.log_bucket_name}" })
}

resource "aws_s3_bucket_acl" "site_logs" {
  bucket = aws_s3_bucket.site.id
  acl    = "log-delivery-write"
}


data "aws_iam_policy_document" "site_policies" {
  statement {
    actions = [
      "s3:GetObject",
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.site.bucket}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "site_policy" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.site_policies.json
}

output "website_endpoint" {
    value = aws_s3_bucket.site.website_endpoint
}
