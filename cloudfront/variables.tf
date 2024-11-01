# variable "partneraX-admin-ui" {
#   description = "Name of the S3 bucket for partneraX admin UI"
#   type        = string
# }

# variable "partneraX-client-ui" {
#   description = "Name of the S3 bucket for partneraX client UI"
#   type        = string
# }

# variable "partneraX-landing-ui" {
#   description = "Name of the S3 bucket for partneraX landing UI"
#   type        = string
# }


variable "s3_photos_bucket_name" {
  description = "The name of the S3 bucket used as the origin."
  type        = string
}

variable "photos_logging_bucket_name" {
  description = "The name of the S3 bucket for CloudFront logging."
  type        = string
}

variable "photos_aliases" {
  description = "The aliases for the CloudFront distribution."
  type        = list(string)
}
variable "translation_aliases" {
  description = "The aliases for the CloudFront distribution."
  type        = list(string)
}

variable "aws_region" {
  description = "The region identifier for cloudfront"
  type = string
}


variable "cloudfront_acm_certificate" {
  description = "Certificate arn url"
  type = string
}

variable "s3_translation_bucket_name" {
  description = "The name of the S3 bucket used as the origin."
  type        = string
}
variable "s3_webapp_bucket_name" {
  description = "The name of the S3 bucket used as the origin."
  type        = string
}
variable "webapp_aliases" {
  description = "The aliases for the CloudFront distribution."
  type        = list(string)
}

variable "s3_adstar_bucket_name" {
  description = "The name of the S3 bucket used as the origin."
  type        = string
}
variable "adstar_aliases" {
  description = "The aliases for the CloudFront distribution."
  type        = list(string)
}


variable "s3_translate_ui_bucket_name" {
  description = "The name of the S3 bucket used as the origin."
  type        = string
}

variable "translate_ui_aliases" {
  description = "The aliases for the CloudFront distribution."
  type        = list(string)
}

variable "cloudfront_cache_policy_id" {
  description = "The name of the cache policy for CloudFront."
  type        = string
}

variable "cloudfront_origin_request_policy_id" {
  description = "The name of the cache policy for CloudFront."
  type        = string
}

variable "sso_aliases" {
  description = "The aliases for the CloudFront distribution."
  type        = list(string)
}

variable "s3_sso_bucket_name" {
  description = "The name of the S3 bucket used as the origin."
  type        = string
}