# ------------------------------------------------------------------------------
# input variable definitions
# ------------------------------------------------------------------------------
variable "bucket_name" {
  type    = string
}

variable "domain" {
  type    = string
}

variable "iam_name" {
  description = "The name to give IAM resources"
  type        = string
}

variable "subject_alternative_names" {
  description = "Additional subject_alternative_names to add to the certificate request (ACM). By default, *.domain is added."
  type        = list
  default     = []
}

variable "cf_aliases" {
  description = "Aliases for the CloudFront distribution. By default, domain and www.domain are added."
  type        = list
  default     = []
}
