# Simple AWS Site Terraform Module

This is a personal Terraform module for deploying a simple website on AWS.

* S3 bucket for the site with logging bucket
* CloudFront distribution
* Route53 DNS management with common records for my own hosts.
* ACM for managing SSL certificates

## Usage

```terraform
module "somesite_aws" {
    source = "git@gitlab.com:joshbeard/tf-aws-site.git"

    domain        = "somesite.org"
    bucket_name   = "s3-website-somesite-org"

    root_txt_records = [
      "hosted-email-verify=kvxv5xvy",
      "v=spf1 include:spf.migadu.com -all"
    ]
}
```
