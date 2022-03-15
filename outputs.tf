output "acm_id" {
  value = aws_acm_certificate.site.id
}

output "acm_arn" {
  value = aws_acm_certificate.site.arn
}

output "acm_domain_name" {
  value = aws_acm_certificate.site.domain_name
}

output "acm_domain_status" {
  value = aws_acm_certificate.site.status
}

output "cloudfront_aliases" {
  value = aws_cloudfront_distribution.site_distribution.aliases
}

output "cloudfront_arn" {
  value = aws_cloudfront_distribution.site_distribution.arn
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.site_distribution.domain_name
}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.site_distribution.id
}

output "iam_deploy_policy_arn" {
  value = aws_iam_policy.site_deploy.arn
}

output "iam_deploy_policy_name" {
  value = aws_iam_policy.site_deploy.name
}

output "iam_deploy_user_arn" {
  value = aws_iam_user.site_deployer.arn
}

output "iam_deploy_user_name" {
  value = aws_iam_user.site_deployer.name
}

output "route53_zone_arn" {
  value = aws_route53_zone.site.arn
}

output "route53_zone_id" {
  value = aws_route53_zone.site.zone_id
}

output "route53_name_servers" {
  value = aws_route53_zone.site.name_servers
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.site.arn
}

output "s3_bucket_domain_name" {
  value = aws_s3_bucket.site.bucket_domain_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.site.bucket
}

output "s3_bucket_regional_domain_name" {
  value = aws_s3_bucket.site.bucket_regional_domain_name
}

output "s3_bucket_website_domain_name" {
  value = aws_s3_bucket.site.bucket_regional_domain_name
}

output "s3_bucket_website_domain" {
  value = aws_s3_bucket_website_configuration.site.website_domain
}

output "s3_bucket_website_endpoint" {
  value = aws_s3_bucket_website_configuration.site.website_endpoint
}
