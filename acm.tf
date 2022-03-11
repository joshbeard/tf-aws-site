# ------------------------------------------------------------------------------
# Certificates
#
# Creates a certificate in ACM and provides a validation resource to create
# corresponding DNS records in Route53.
# ------------------------------------------------------------------------------
resource "aws_acm_certificate" "site" {
  provider                  = aws.cert
  domain_name               = var.domain
  validation_method         = "DNS"
  subject_alternative_names = compact(concat(["*.${var.domain}"], var.subject_alternative_names))

  lifecycle {
    create_before_destroy = true
  }

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  tags = merge(local.tags, { "Name" = var.domain })
}

resource "aws_acm_certificate_validation" "site" {
  provider                = aws.cert
  certificate_arn         = aws_acm_certificate.site.arn
  validation_record_fqdns = [for record in aws_route53_record.site_acm_validate : record.fqdn]
}
