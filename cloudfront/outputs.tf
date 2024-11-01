output "cloudfront_photos_distribution_id" {
  value = aws_cloudfront_distribution.photos_s3_distribution.id
  description = "The ID of the CloudFront distribution for photos."
}

output "cloudfront_photos_distribution_domain_name" {
  value = aws_cloudfront_distribution.photos_s3_distribution.domain_name
  description = "The domain name of the CloudFront distribution for photos."
}

# output "cloudfront_photos_origin_access_identity_id" {
#   value = aws_cloudfront_origin_access_identity.photos_s3_oai.id
#   description = "The ID of the CloudFront origin access identity for photos distribution."
# }


output "cloudfront_translation_distribution_id" {
  value = aws_cloudfront_distribution.translation_s3_distribution.id
  description = "The ID of the CloudFront distribution for translation."
}

output "cloudfront_translation_distribution_domain_name" {
  value = aws_cloudfront_distribution.translation_s3_distribution.domain_name
  description = "The domain name of the CloudFront distribution for translation."
}

# output "cloudfront_translation_origin_access_identity_id" {
#   value = aws_cloudfront_origin_access_identity.translation_s3_oai.id
#   description = "The ID of the CloudFront origin access identity for translation distribution."
# }

output "cloudfront_webapp_distribution_id" {
  value = aws_cloudfront_distribution.webapp_s3_distribution.id
  description = "The ID of the CloudFront distribution for webapp."
}

output "cloudfront_webapp_distribution_domain_name" {
  value = aws_cloudfront_distribution.webapp_s3_distribution.domain_name
  description = "The domain name of the CloudFront distribution for webapp."
}

# output "cloudfront_webapp_origin_access_identity_id" {
#   value = aws_cloudfront_origin_access_identity.webapp_s3_oai.id
#   description = "The ID of the CloudFront origin access identity for webapp distribution."
# }


output "cloudfront_adstar_distribution_id" {
  value = aws_cloudfront_distribution.adstar_s3_distribution.id
  description = "The ID of the CloudFront distribution for adstar."
}

output "cloudfront_adstar_distribution_domain_name" {
  value = aws_cloudfront_distribution.adstar_s3_distribution.domain_name
  description = "The domain name of the CloudFront distribution for adstar."
}

# output "cloudfront_adstar_origin_access_identity_id" {
#   value = aws_cloudfront_origin_access_identity.adstar_s3_oai.id
#   description = "The ID of the CloudFront origin access identity for adstar distribution."
# }

output "cloudfront_translate_ui_distribution_id" {
  value = aws_cloudfront_distribution.translate_ui_s3_distribution.id
  description = "The ID of the CloudFront distribution for translate-ui."
}

output "cloudfront_translate_ui_distribution_domain_name" {
  value = aws_cloudfront_distribution.translate_ui_s3_distribution.domain_name
  description = "The domain name of the CloudFront distribution for translate-ui."
}

# output "cloudfront_translate_ui_origin_access_identity_id" {
#   value = aws_cloudfront_origin_access_identity.translate_ui_s3_oai.id
#   description = "The ID of the CloudFront origin access identity for translate-ui distribution."
# }


output "cloudfront_sso_distribution_id" {
  value = aws_cloudfront_distribution.sso_s3_distribution.id
  description = "The ID of the CloudFront distribution for sso."
}

output "cloudfront_sso_distribution_domain_name" {
  value = aws_cloudfront_distribution.sso_s3_distribution.domain_name
  description = "The domain name of the CloudFront distribution for sso."
}

# output "cloudfront_sso_origin_access_identity_id" {
#   value = aws_cloudfront_origin_access_identity.sso_s3_oai.id
#   description = "The ID of the CloudFront origin access identity for sso-ui distribution."
# }