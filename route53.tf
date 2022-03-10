# ------------------------------------------------------------------------------
# route53 DNS
# ------------------------------------------------------------------------------
resource "aws_route53_zone" "site" {
  name = var.domain
  tags = local.tags
}

# ACM validation
resource "aws_route53_record" "site_acm_validate" {
  for_each = {
    for dvo in aws_acm_certificate.site.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.site.zone_id
}

resource "aws_route53_record" "site-root-a" {
  provider = aws.cert
  zone_id  = aws_route53_zone.site.zone_id
  name     = var.domain
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.site_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.site_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "site-www-a" {
  provider = aws.cert
  zone_id  = aws_route53_zone.site.zone_id
  name     = "www.${var.domain}" #var.domain
  type     = "A"

  alias {
    name                   = aws_cloudfront_distribution.site_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.site_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
