output "acm_id" {
  description = "The ID of the certificate in ACM."
  value       = aws_acm_certificate.site.id
}

output "acm_arn" {
  description = "The ARN of the certificate in ACM."
  value       = aws_acm_certificate.site.arn
}

output "acm_domain_name" {
  description = "The domain name of the certificate in ACM."
  value       = aws_acm_certificate.site.domain_name
}

output "acm_domain_status" {
  description = "The status of the certificate in ACM."
  value       = aws_acm_certificate.site.status
}

output "cloudfront_aliases" {
  description = "List of aliases for the CloudFront distribution."
  value       = aws_cloudfront_distribution.site_distribution.aliases
}

output "cloudfront_arn" {
  description = "The ARN of the CloudFront distribution."
  value       = aws_cloudfront_distribution.site_distribution.arn
}

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution."
  value       = aws_cloudfront_distribution.site_distribution.domain_name
}

output "cloudfront_id" {
  description = "The ID of the CloudFront distribution."
  value       = aws_cloudfront_distribution.site_distribution.id
}

output "iam_deploy_policy_arn" {
  description = "The ARN of the IAM policy used by the IAM user for deployment."
  value       = aws_iam_policy.site_deploy.arn
}

output "iam_deploy_policy_name" {
  description = "The name of the IAM policy used by the IAM user for deployment."
  value       = aws_iam_policy.site_deploy.name
}

output "iam_deploy_user_arn" {
  description = "The ARN of the IAM user used for deployment."
  value       = aws_iam_user.site_deployer.arn
}

output "iam_deploy_user_name" {
  description = "The name of the IAM user used for deployment."
  value       = aws_iam_user.site_deployer.name
}

output "route53_zone_arn" {
  description = "The ARN of the Route53 zone."
  value       = aws_route53_zone.site.arn
}

output "route53_zone_id" {
  description = "The ID of the Route53 zone."
  value       = aws_route53_zone.site.zone_id
}

output "route53_name_servers" {
  description = "List of name servers for the Route53 zone."
  value       = aws_route53_zone.site.name_servers
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket containing the web content."
  value       = aws_s3_bucket.site.arn
}

output "s3_bucket_domain_name" {
  description = "The AWS domain of the S3 bucket containing the web content."
  value       = aws_s3_bucket.site.bucket_domain_name
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket containing the web content."
  value       = aws_s3_bucket.site.bucket
}

output "s3_bucket_regional_domain_name" {
  description = "The AWS regional domain of the S3 bucket containing the web content."
  value       = aws_s3_bucket.site.bucket_regional_domain_name
}

output "s3_bucket_website_domain" {
  description = "The AWS website domain of the S3 bucket containing the web content."
  value       = aws_s3_bucket_website_configuration.site.website_domain
}

output "s3_bucket_website_endpoint" {
  description = "The AWS website endpoint of the S3 bucket containing the web content."
  value       = aws_s3_bucket_website_configuration.site.website_endpoint
}
