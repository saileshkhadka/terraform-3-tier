# #photos bucket resources oai
# resource "aws_cloudfront_origin_access_identity" "photos_s3_oai" {
#   comment = "Origin Access Identity for S3 photos bucket"
# }

# #translation bucket resources oai
# resource "aws_cloudfront_origin_access_identity" "translation_s3_oai" {
#   comment = "Origin Access Identity for S3 translation bucket"
# }

# #webapp bucket resources oai
# resource "aws_cloudfront_origin_access_identity" "webapp_s3_oai" {
#   comment = "Origin Access Identity for S3 webapp bucket"
# }

# #adstar bucket resources oai
# resource "aws_cloudfront_origin_access_identity" "adstar_s3_oai" {
#   comment = "Origin Access Identity for S3 adstar bucket"
# }

# #translate-ui bucket resources oai
# resource "aws_cloudfront_origin_access_identity" "translate_ui_s3_oai" {
#   comment = "Origin Access Identity for S3 translate-ui bucket"
# }


locals {
  # s3_origin_id = "dev-${var.s3_photos_bucket_name}.s3.${var.aws_region}.amazonaws.com"
  photos_s3_origin_id = "dev-${var.s3_photos_bucket_name}.s3.${var.aws_region}.amazonaws.com"
  translation_s3_origin_id = "dev-${var.s3_translation_bucket_name}.s3.${var.aws_region}.amazonaws.com"
  webapp_s3_origin_id = "dev-${var.s3_webapp_bucket_name}.s3.${var.aws_region}.amazonaws.com"
  adstar_s3_origin_id = "dev-${var.s3_adstar_bucket_name}.s3.${var.aws_region}.amazonaws.com"
  translate_ui_s3_origin_id = "dev-${var.s3_translate_ui_bucket_name}.s3.${var.aws_region}.amazonaws.com"
  sso_s3_origin_id = "dev-${var.s3_sso_bucket_name}.s3.${var.aws_region}.amazonaws.com"


}


resource "aws_cloudfront_origin_access_control" "photos_ui_oac" {
  name        = "dev-photos-partneraX"
  description = "Origin Access Control for S3 photos-ui bucket"
  signing_behavior = "always"  # Sign requests (recommended)
  
  origin_access_control_origin_type = "s3"  # Specify the origin type
  signing_protocol = "sigv4"  # Specify the signing protocol
}

#resources for photos bucket
resource "aws_cloudfront_distribution" "photos_s3_distribution" {
  origin {
    domain_name              = "dev-photos-partneraX.s3.${var.aws_region}.amazonaws.com"
    origin_id                = local.photos_s3_origin_id

# s3_origin_config {
#   origin_access_identity = aws_cloudfront_origin_access_identity.photos_s3_oai.cloudfront_access_identity_path
# }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "photos.partneraX.eu"
  default_root_object = "index.html"

  # logging_config {
  #   include_cookies = false
  #   bucket          = "${var.photos_logging_bucket_name}.s3.amazonaws.com"
  #   # bucket            = "${aws_s3_bucket.partneraX_photos_logging.bucket}.s3.amazonaws.com"
  #   prefix          = "partneraX-prefix"
  # }

  aliases = var.photos_aliases

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.photos_s3_origin_id

    compress = true

    # Reference cache policy and origin request policy
    cache_policy_id       = var.cloudfront_cache_policy_id
    origin_request_policy_id = var.cloudfront_origin_request_policy_id

    # forwarded_values {
    #   query_string = false

    #   cookies {
    #     forward = "none"
    #   }
    # }

    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["CN", "RU"]
    }
  }

  tags = {
    Environment = "devuction"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    acm_certificate_arn = var.cloudfront_acm_certificate
    ssl_support_method  = "sni-only"
  }
   #custom error page
  custom_error_response {
    error_code             = 404
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }

  custom_error_response {
    error_code             = 403
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }

}

resource "aws_cloudfront_origin_access_control" "translation_ui_oac" {
  name        = "dev-translation-partneraX "
  description = "Origin Access Control for S3 translation-ui bucket"
  signing_behavior = "always"  # Sign requests (recommended)
  
  origin_access_control_origin_type = "s3"  # Specify the origin type
  signing_protocol = "sigv4"  # Specify the signing protocol
}


#resource for translation distribution
resource "aws_cloudfront_distribution" "translation_s3_distribution" {
  origin {
    domain_name              = "dev-translation-partneraX.s3.${var.aws_region}.amazonaws.com"
    origin_id                = local.translation_s3_origin_id

# s3_origin_config {
#   origin_access_identity = aws_cloudfront_origin_access_identity.translation_s3_oai.cloudfront_access_identity_path
# }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "translation.partneraX.eu"
  default_root_object = "index.html"

  # logging_config {
  #   include_cookies = false
  #   bucket          = "${var.photos_logging_bucket_name}.s3.amazonaws.com"
  #   # bucket            = "${aws_s3_bucket.partneraX_photos_logging.bucket}.s3.amazonaws.com"
  #   prefix          = "partneraX-prefix"
  # }

  aliases = var.translation_aliases

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.translation_s3_origin_id

    compress = true

    # Reference cache policy and origin request policy
    cache_policy_id       = var.cloudfront_cache_policy_id
    origin_request_policy_id = var.cloudfront_origin_request_policy_id

    # forwarded_values {
    #   query_string = false

    #   cookies {
    #     forward = "none"
    #   }
    # }

    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["CN", "RU"]
    }
  }

  tags = {
    Environment = "devuction"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = var.cloudfront_acm_certificate
    ssl_support_method  = "sni-only"
  }
   #custom error page
  custom_error_response {
    error_code             = 404
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }

  custom_error_response {
    error_code             = 403
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }

}

resource "aws_cloudfront_origin_access_control" "webapp_ui_oac" {
  name        = "dev-webapp-partneraX"
  description = "Origin Access Control for S3 webapp-ui bucket"
  signing_behavior = "always"  # Sign requests (recommended)
  
  origin_access_control_origin_type = "s3"  # Specify the origin type
  signing_protocol = "sigv4"  # Specify the signing protocol
}

#resource for webapp distribution
resource "aws_cloudfront_distribution" "webapp_s3_distribution" {
  origin {
    domain_name              = "dev-webapp-partneraX.s3.${var.aws_region}.amazonaws.com"
    origin_id                = local.webapp_s3_origin_id

# s3_origin_config {
#   origin_access_identity = aws_cloudfront_origin_access_identity.webapp_s3_oai.cloudfront_access_identity_path
# }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "webapp-v2.partneraX.eu"
  default_root_object = "index.html"

  # logging_config {
  #   include_cookies = false
  #   bucket          = "${var.webapp_logging_bucket_name}.s3.amazonaws.com"
  #   # bucket            = "${aws_s3_bucket.partneraX_webapp_logging.bucket}.s3.amazonaws.com"
  #   prefix          = "partneraX-prefix"
  # }

  aliases = var.webapp_aliases

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.webapp_s3_origin_id

    compress = true

    # Reference cache policy and origin request policy
    cache_policy_id       = var.cloudfront_cache_policy_id
    origin_request_policy_id = var.cloudfront_origin_request_policy_id

    # forwarded_values {
    #   query_string = false

    #   cookies {
    #     forward = "none"
    #   }
    # }

    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["CN", "RU"]
    }
  }

  tags = {
    Environment = "devuction"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = var.cloudfront_acm_certificate
    ssl_support_method  = "sni-only"
  }
 #custom error page
  custom_error_response {
    error_code             = 404
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }

   custom_error_response {
    error_code             = 403
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }


}

resource "aws_cloudfront_origin_access_control" "adstar_ui_oac" {
  name        = "dev-adstar-partneraX"
  description = "Origin Access Control for S3 adstar-ui bucket"
  signing_behavior = "always"  # Sign requests (recommended)
  
  origin_access_control_origin_type = "s3"  # Specify the origin type
  signing_protocol = "sigv4"  # Specify the signing protocol
}


#resource for adstar distribution
resource "aws_cloudfront_distribution" "adstar_s3_distribution" {
  origin {
    domain_name              = "dev-adstar-partneraX.s3.${var.aws_region}.amazonaws.com"
    origin_id                = local.adstar_s3_origin_id

# s3_origin_config {
#   origin_access_identity = aws_cloudfront_origin_access_identity.adstar_s3_oai.cloudfront_access_identity_path
# }

  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "adstar-v2.partneraX.eu"
  default_root_object = "index.html"

  # logging_config {
  #   include_cookies = false
  #   bucket          = "${var.adstar_logging_bucket_name}.s3.amazonaws.com"
  #   # bucket            = "${aws_s3_bucket.partneraX_adstar_logging.bucket}.s3.amazonaws.com"
  #   prefix          = "partneraX-prefix"
  # }

  aliases = var.adstar_aliases

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.adstar_s3_origin_id

    compress = true

    # Reference cache policy and origin request policy
    cache_policy_id       = var.cloudfront_cache_policy_id
    origin_request_policy_id = var.cloudfront_origin_request_policy_id

    # forwarded_values {
    #   query_string = false

    #   cookies {
    #     forward = "none"
    #   }
    # }

    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["CN", "RU"]
    }
  }

  tags = {
    Environment = "devuction"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = var.cloudfront_acm_certificate
    ssl_support_method  = "sni-only"
  }
 #custom error page
  custom_error_response {
    error_code             = 404
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }

  custom_error_response {
    error_code             = 403
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }

}



resource "aws_cloudfront_origin_access_control" "translate_ui_oac" {
  name        = "dev-translate-ui-partneraX"
  description = "Origin Access Control for S3 translate-ui bucket"
  signing_behavior = "always"  # Sign requests (recommended)
  
  origin_access_control_origin_type = "s3"  # Specify the origin type
  signing_protocol = "sigv4"  # Specify the signing protocol
}

#resource for translate-ui distribution
resource "aws_cloudfront_distribution" "translate_ui_s3_distribution" {
  origin {
    domain_name              = "dev-translate-ui-partneraX.s3.${var.aws_region}.amazonaws.com"
    origin_id                = local.translate_ui_s3_origin_id

# s3_origin_config {
#   origin_access_control_id = aws_cloudfront_origin_access_control.translate_ui_oac.id
# }


  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "translate-ui.partneraX.eu"
  default_root_object = "index.html"

  # logging_config {
  #   include_cookies = false
  #   bucket          = "${var.adstar_logging_bucket_name}.s3.amazonaws.com"
  #   # bucket            = "${aws_s3_bucket.partneraX_adstar_logging.bucket}.s3.amazonaws.com"
  #   prefix          = "partneraX-prefix"
  # }

  aliases = var.translate_ui_aliases

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.translate_ui_s3_origin_id
    compress = true

    # Reference cache policy and origin request policyf
    cache_policy_id       = var.cloudfront_cache_policy_id
    origin_request_policy_id = var.cloudfront_origin_request_policy_id

    # forwarded_values {
    #   query_string = false

    #   cookies {
    #     forward = "none"
    #   }
    # }

    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["CN", "RU"]
    }
  }

  tags = {
    Environment = "devuction"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = var.cloudfront_acm_certificate
    ssl_support_method  = "sni-only"
  }

   #custom error page
  custom_error_response {
    error_code             = 404
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }

  custom_error_response {
    error_code             = 403
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }
}



resource "aws_cloudfront_origin_access_control" "sso_oac" {
  name        = "dev-sso-partneraX"
  description = "Origin Access Control for S3 sso bucket"
  signing_behavior = "always"  # Sign requests (recommended)
  
  origin_access_control_origin_type = "s3"  # Specify the origin type
  signing_protocol = "sigv4"  # Specify the signing protocol
}

#resource for sso distribution
resource "aws_cloudfront_distribution" "sso_s3_distribution" {
  origin {
    domain_name              = "dev-sso-partneraX.s3.${var.aws_region}.amazonaws.com"
    origin_id                = local.sso_s3_origin_id

# s3_origin_config {
#   origin_access_control_id = aws_cloudfront_origin_access_control.sso_oac.id
# }


  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "app-v2.partneraX.eu"
  default_root_object = "index.html"

  # logging_config {
  #   include_cookies = false
  #   bucket          = "${var.sso_logging_bucket_name}.s3.amazonaws.com"
  #   # bucket            = "${aws_s3_bucket.partneraX_sso_logging.bucket}.s3.amazonaws.com"
  #   prefix          = "partneraX-prefix"
  # }

  aliases = var.sso_aliases

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.sso_s3_origin_id
    compress = true

    # Reference cache policy and origin request policyf
    cache_policy_id       = var.cloudfront_cache_policy_id
    origin_request_policy_id = var.cloudfront_origin_request_policy_id

    # forwarded_values {
    #   query_string = false

    #   cookies {
    #     forward = "none"
    #   }
    # }

    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["CN", "RU"]
    }
  }

  tags = {
    Environment = "devuction"
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn = var.cloudfront_acm_certificate
    ssl_support_method  = "sni-only"
  }

   #custom error page
  custom_error_response {
    error_code             = 404
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }

  custom_error_response {
    error_code             = 403
    response_page_path     = "/index.html"
    response_code          = 200
    error_caching_min_ttl  = 10
  }
}