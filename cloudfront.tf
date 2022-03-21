# ------------------------------------------------------------------------------
# CloudFront distribution
# ------------------------------------------------------------------------------
resource "aws_cloudfront_origin_access_identity" "site" {
  comment = "${var.domain}-cf-s3"
}

resource "aws_cloudfront_distribution" "site_distribution" {
  origin {
    domain_name = aws_s3_bucket.site.bucket_regional_domain_name
    origin_id   = "S3Origin-${aws_s3_bucket.site.bucket}"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.site.cloudfront_access_identity_path
    }

    origin_shield {
      enabled              = true
      origin_shield_region = "us-west-2"
    }
  }

  # US, Canada, UK, Europe
  price_class         = "PriceClass_100"
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = compact(concat(["www.${var.domain}", var.domain], var.cf_aliases))

  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.site_logs.bucket_domain_name
    prefix          = var.log_prefix != null ? var.log_prefix : "${var.domain}/"
  }

  default_cache_behavior {
    compress         = true
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin-${aws_s3_bucket.site.bucket}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.cf_min_ttl
    default_ttl            = var.cf_default_ttl
    max_ttl                = var.cf_max_ttl
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.site.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = local.tags
}

module "cloudfront_logs" {
  count  = var.cf_logs ? 1 : 0
  source = "./cloudfront-logs"

  name        = local.hyphen_domain_name
  name_prefix = "cf-logs"
  tags        = local.tags
  log_bucket  = aws_s3_bucket.site_logs.bucket
}
