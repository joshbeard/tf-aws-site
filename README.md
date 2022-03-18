# Simple AWS Site Terraform Module

This is a personal Terraform module for deploying a simple website on AWS.

* S3 bucket for the site with logging bucket
* CloudFront distribution
* Route53 DNS management with common records for my own hosts.
* ACM for managing SSL certificates
* IAM policy and user for deployment

## Usage

```terraform
module "somesite_aws" {
    source = "git@gitlab.com:joshbeard/tf-aws-site.git"

    domain = "somesite.org"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.4.0 |
| <a name="provider_aws.cert"></a> [aws.cert](#provider\_aws.cert) | 4.4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_cloudfront_distribution.site_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_iam_policy.site_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_user.site_deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.site_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_route53_record.site-root-a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.site-www-a](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.site_acm_validate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_s3_bucket.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.site_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_acl.site_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_cors_configuration.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_logging.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_policy.site_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_website_configuration.site](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_iam_policy_document.site_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.site_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the S3 bucket to manage for the web content. By default, this is s3-website-DOMAINSLUG | `string` | `null` | no |
| <a name="input_cf_aliases"></a> [cf\_aliases](#input\_cf\_aliases) | Aliases for the CloudFront distribution. By default, domain and www.domain are added. | `list(any)` | `[]` | no |
| <a name="input_cf_default_ttl"></a> [cf\_default\_ttl](#input\_cf\_default\_ttl) | The default TTL for the CloudFront distribution default behavior. | `number` | `2592000` | no |
| <a name="input_cf_max_ttl"></a> [cf\_max\_ttl](#input\_cf\_max\_ttl) | The maximum TTL for the CloudFront distribution default behavior. | `number` | `7776000` | no |
| <a name="input_cf_min_ttl"></a> [cf\_min\_ttl](#input\_cf\_min\_ttl) | The minimum TTL for the CloudFront distribution default behavior. | `number` | `0` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The DNS name of the site. | `string` | n/a | yes |
| <a name="input_iam_name"></a> [iam\_name](#input\_iam\_name) | The name to give IAM resources. By default, this is s3-deployer-DOMAINSLUG | `string` | `null` | no |
| <a name="input_log_bucket_name"></a> [log\_bucket\_name](#input\_log\_bucket\_name) | The name of the S3 bucket to manage for logging. By default, this is s3-website-DOMAINSLUG-logs | `string` | `null` | no |
| <a name="input_log_prefix"></a> [log\_prefix](#input\_log\_prefix) | The prefix (path) for logs in the logging bucket. By default, this is the value of 'domain' | `string` | `null` | no |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | Additional subject\_alternative\_names to add to the certificate request (ACM). By default, *.domain is added. | `list(any)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to apply to all resources. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_arn"></a> [acm\_arn](#output\_acm\_arn) | n/a |
| <a name="output_acm_domain_name"></a> [acm\_domain\_name](#output\_acm\_domain\_name) | n/a |
| <a name="output_acm_domain_status"></a> [acm\_domain\_status](#output\_acm\_domain\_status) | n/a |
| <a name="output_acm_id"></a> [acm\_id](#output\_acm\_id) | n/a |
| <a name="output_cloudfront_aliases"></a> [cloudfront\_aliases](#output\_cloudfront\_aliases) | n/a |
| <a name="output_cloudfront_arn"></a> [cloudfront\_arn](#output\_cloudfront\_arn) | n/a |
| <a name="output_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#output\_cloudfront\_domain\_name) | n/a |
| <a name="output_cloudfront_id"></a> [cloudfront\_id](#output\_cloudfront\_id) | n/a |
| <a name="output_iam_deploy_policy_arn"></a> [iam\_deploy\_policy\_arn](#output\_iam\_deploy\_policy\_arn) | n/a |
| <a name="output_iam_deploy_policy_name"></a> [iam\_deploy\_policy\_name](#output\_iam\_deploy\_policy\_name) | n/a |
| <a name="output_iam_deploy_user_arn"></a> [iam\_deploy\_user\_arn](#output\_iam\_deploy\_user\_arn) | n/a |
| <a name="output_iam_deploy_user_name"></a> [iam\_deploy\_user\_name](#output\_iam\_deploy\_user\_name) | n/a |
| <a name="output_route53_name_servers"></a> [route53\_name\_servers](#output\_route53\_name\_servers) | n/a |
| <a name="output_route53_zone_arn"></a> [route53\_zone\_arn](#output\_route53\_zone\_arn) | n/a |
| <a name="output_route53_zone_id"></a> [route53\_zone\_id](#output\_route53\_zone\_id) | n/a |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | n/a |
| <a name="output_s3_bucket_domain_name"></a> [s3\_bucket\_domain\_name](#output\_s3\_bucket\_domain\_name) | n/a |
| <a name="output_s3_bucket_name"></a> [s3\_bucket\_name](#output\_s3\_bucket\_name) | n/a |
| <a name="output_s3_bucket_regional_domain_name"></a> [s3\_bucket\_regional\_domain\_name](#output\_s3\_bucket\_regional\_domain\_name) | n/a |
| <a name="output_s3_bucket_website_domain"></a> [s3\_bucket\_website\_domain](#output\_s3\_bucket\_website\_domain) | n/a |
| <a name="output_s3_bucket_website_domain_name"></a> [s3\_bucket\_website\_domain\_name](#output\_s3\_bucket\_website\_domain\_name) | n/a |
| <a name="output_s3_bucket_website_endpoint"></a> [s3\_bucket\_website\_endpoint](#output\_s3\_bucket\_website\_endpoint) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
