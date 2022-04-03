# ------------------------------------------------------------------------------
# CloudFront distribution
# ------------------------------------------------------------------------------
resource "aws_cloudfront_distribution" "site_distribution" {
  origin {
    domain_name = aws_s3_bucket.site.website_endpoint
    origin_id   = "S3Origin-${aws_s3_bucket.site.bucket}"

    origin_shield {
      enabled              = true
      origin_shield_region = var.region
    }

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
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
  log_bucket  = aws_s3_bucket.site_logs.arn
}
