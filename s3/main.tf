# Artifact Bucket
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket_prefix = regex("[a-z0-9.-]+", lower(var.app_name))
  tags          = var.tags
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_access" {
  bucket                  = aws_s3_bucket.codepipeline_bucket.id
  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
}

data "aws_iam_policy_document" "bucket_policy_doc_codepipeline_bucket" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.codepipeline_role_arn]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ReplicateObject",
      "s3:PutObject",
      "s3:RestoreObject",
      "s3:PutObjectVersionTagging",
      "s3:PutObjectTagging",
      "s3:PutObjectAcl"
    ]

    resources = [
      aws_s3_bucket.codepipeline_bucket.arn,
      "${aws_s3_bucket.codepipeline_bucket.arn}/*"
    ]
  }
  statement {
    effect = "Allow"

    actions = ["*"]

    resources = ["*"]
      principals {
      type        = "AWS"
      identifiers = [var.codepipeline_role_arn]
    }
  }
    statement {
    effect = "Allow"
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild"
    ]
    resources = ["*"]
      principals {
      type        = "AWS"
      identifiers = [var.codepipeline_role_arn]
    }
  }
}

resource "aws_s3_bucket_versioning" "codepipeline_bucket_versioning" {
  bucket = aws_s3_bucket.codepipeline_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "codepipeline_bucket_encryption" {
  bucket = aws_s3_bucket.codepipeline_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_logging" "codepipeline_bucket_logging" {
  bucket        = aws_s3_bucket.codepipeline_bucket.id
  target_bucket = aws_s3_bucket.codepipeline_bucket.id
  target_prefix = "log/"
}



#resource for photos_bucket
resource "aws_s3_bucket" "partneraX_photos" {
  bucket = lower("dev-photos-${var.app_name}") 

  tags = {
    Name = "dev-partneraX-photos-bucket"
  }
}

# resource "aws_s3_bucket_acl" "partneraX_photos_acl" {
#   bucket = aws_s3_bucket.partneraX_photos.id
#   acl    = "private"
# }

resource "aws_s3_bucket" "partneraX_photos_logging" {
  bucket = var.photos_logging_bucket_name

  tags = {
    Name = "dev-photos-partneraX-logging-bucket"
  }
}

#bucket policy for photos bucket

resource "aws_s3_bucket_policy" "photos_bucket_policy" {
  bucket = aws_s3_bucket.partneraX_photos.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.partneraX_photos.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_photos_distribution_id}"
          }
        }
      }
    ]
  })
}

#resource for translation bucket

resource "aws_s3_bucket" "partneraX_translation_bucket" {
  bucket = lower("dev-translation-${var.app_name}") 

  tags = {
    Name = "dev-partneraX-translation-bucket"
  }
}

# resource "aws_s3_bucket_acl" "partneraX_translation_bucket" {
#   bucket = aws_s3_bucket.partneraX_translation_bucket.id
#   acl    = "private"
# }

resource "aws_s3_bucket" "partneraX_translation_logging" {
  bucket = var.translation_logging_bucket_name

  tags = {
    Name = "dev-partneraX-translation-logging-bucket"
  }
}

#bucket policy for translation bucket

resource "aws_s3_bucket_policy" "translation_bucket_policy" {
  bucket = aws_s3_bucket.partneraX_translation_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.partneraX_translation_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_translation_distribution_id}"
          }
        }
      }
    ]
  })
}



#resource for dev webapp bucket

resource "aws_s3_bucket" "partneraX_webapp_bucket" {
  bucket = lower("dev-webapp-${var.app_name}") 

  tags = {
    Name = "dev-partneraX-webapp-bucket"
  }
}

# resource "aws_s3_bucket_acl" "partneraX_webapp_bucket" {
#   bucket = aws_s3_bucket.partneraX_webapp_bucket.id
#   acl    = "private"
# }

resource "aws_s3_bucket" "partneraX_webapp_logging" {
  bucket = var.webapp_logging_bucket_name

  tags = {
    Name = "dev-partneraX-webapp-logging-bucket"
  }
}

#bucket policy for dev webapp bucket

resource "aws_s3_bucket_policy" "webapp_bucket_policy" {
  bucket = aws_s3_bucket.partneraX_webapp_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.partneraX_webapp_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_webapp_distribution_id}"
          }
        }
      }
    ]
  })
}


#resource for dev adstar bucket
resource "aws_s3_bucket" "partneraX_adstar_bucket" {
  bucket = lower("dev-adstar-${var.app_name}") 

  tags = {
    Name = "dev-partneraX-adstar-bucket"
  }
}

# resource "aws_s3_bucket_acl" "partneraX_adstar_bucket" {
#   bucket = aws_s3_bucket.partneraX_adstar_bucket.id
#   acl    = "private"
# }

resource "aws_s3_bucket" "partneraX_adstar_logging" {
  bucket = var.adstar_logging_bucket_name

  tags = {
    Name = "dev-partneraX-adstar-logging-bucket"
  }
}

#bucket policy for dev webapp bucket

resource "aws_s3_bucket_policy" "adstar_bucket_policy" {
  bucket = aws_s3_bucket.partneraX_adstar_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.partneraX_adstar_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_adstar_distribution_id}"
          }
        }
      }
    ]
  })
}


#resource for dev translate-ui bucket
resource "aws_s3_bucket" "partneraX_translate_ui_bucket" {
  bucket = lower("dev-translate-ui-${var.app_name}") 

  tags = {
    Name = "dev-partneraX-translate-ui-bucket"
  }
}

# resource "aws_s3_bucket_acl" "partneraX_translate_ui_bucket" {
#   bucket = aws_s3_bucket.partneraX_translate_ui_bucket.id
#   acl    = "private"
# }

resource "aws_s3_bucket" "partneraX_translate_ui_logging" {
  bucket = var.translate_ui_logging_bucket_name

  tags = {
    Name = "dev-partneraX-transalte-ui-logging-bucket"
  }
}

#bucket policy for dev translate-ui bucket

resource "aws_s3_bucket_policy" "translate_ui_bucket_policy" {
  bucket = aws_s3_bucket.partneraX_translate_ui_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.partneraX_translate_ui_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_translate_ui_distribution_id}"
          }
        }
      }
    ]
  })
}



#resource for dev sso-ui bucket
resource "aws_s3_bucket" "sso_bucket" {
  bucket = lower("dev-sso-${var.app_name}") 

  tags = {
    Name = "dev-partneraX-sso-bucket"
  }
}

# resource "aws_s3_bucket_acl" "partneraX_translate_ui_bucket" {
#   bucket = aws_s3_bucket.partneraX_translate_ui_bucket.id
#   acl    = "private"
# }

# resource "aws_s3_bucket" "sso_ui_logging" {
#   bucket = var.sso_ui_logging_bucket_name

#   tags = {
#     Name = "dev-partneraX-sso-ui-logging-bucket"
#   }
# }

#bucket policy for dev sso bucket

resource "aws_s3_bucket_policy" "sso_bucket_policy" {
  bucket = aws_s3_bucket.sso_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.sso_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${var.cloudfront_sso_distribution_id}"
          }
        }
      }
    ]
  })
}





data "aws_caller_identity" "current" {}



