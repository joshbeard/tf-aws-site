variable "name" {
  description = "Name used for resources."
  type        = string
}

variable "name_prefix" {
  description = "Prefix to add to resource names."
  type        = string
}

variable "retention" {
  description = "Retention in days for log files in S3 Bucket and CloudWatch Logs group."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags used for all created resources."
  type        = map(string)
  default     = {}
}

variable "log_bucket" {
  description = "The ARN of the log bucket"
  type        = string
}