variable "app_name" {
  description = "Name of the project to be prefixed to create the s3 bucket"
  type        = string
}
variable "tags" {
  description = "Tags to be associated with the S3 bucket"
  type        = map(any)
}

variable "kms_key_arn" {
  description = "ARN of KMS key for encryption"
  type        = string
}

variable "codepipeline_role_arn" {
  description = "ARN of the codepipeline IAM role"
  type        = string
}

variable "photos_logging_bucket_name" {
  description = "logging-bucket-name"
  type        = string
}

variable "cloudfront_photos_distribution_id" {
  description = "The ID of the CloudFront distribution for photos."
  type        = string
}

variable "translation_logging_bucket_name" {
  description = "logging-bucket-name"
  type        = string
}

variable "cloudfront_translation_distribution_id" {
  description = "The ID of the CloudFront distribution for translation."
  type        = string
}
variable "webapp_logging_bucket_name" {
  description = "logging-bucket-name"
  type        = string
}

variable "cloudfront_webapp_distribution_id" {
  description = "The ID of the CloudFront distribution for translation."
  type        = string
}

variable "adstar_logging_bucket_name" {
  description = "logging-bucket-name"
  type        = string
}

variable "cloudfront_adstar_distribution_id" {
  description = "The ID of the CloudFront distribution for translation."
  type        = string
}

variable "translate_ui_logging_bucket_name" {
  description = "logging-bucket-name"
  type        = string
}

variable "cloudfront_translate_ui_distribution_id" {
  description = "The ID of the CloudFront distribution for translation."
  type        = string
}

variable "cloudfront_sso_distribution_id" {
  description = "The ID of the CloudFront distribution for translation."
  type        = string
}