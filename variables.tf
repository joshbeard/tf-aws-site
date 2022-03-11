# ------------------------------------------------------------------------------
# input variable definitions
# ------------------------------------------------------------------------------
variable "domain" {
  description = "The DNS name of the site."
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket to manage for the web content. By default, this is s3-website-DOMAINSLUG"
  type        = string
  default     = null
}

variable "log_bucket_name" {
  description = "The name of the S3 bucket to manage for logging. By default, this is s3-website-DOMAINSLUG-logs"
  type        = string
  default     = null
}

variable "log_prefix" {
  description = "The prefix (path) for logs in the logging bucket. By default, this is the value of 'domain'"
  type        = string
  default     = null
}

variable "iam_name" {
  description = "The name to give IAM resources. By default, this is s3-deployer-DOMAINSLUG"
  type        = string
  default     = null
}

variable "subject_alternative_names" {
  description = "Additional subject_alternative_names to add to the certificate request (ACM). By default, *.domain is added."
  type        = list(any)
  default     = []
}

variable "cf_aliases" {
  description = "Aliases for the CloudFront distribution. By default, domain and www.domain are added."
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Map of tags to apply to all resources."
  type        = map(any)
  default     = {}
}