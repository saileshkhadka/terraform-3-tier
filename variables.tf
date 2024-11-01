variable "region" {
  description = "The AWS region to deploy to"
  type        = string
}

variable "profile" {
  description = "The AWS CLI profile to use"
  type        = string
  default     = "default"
}

variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "VPC_name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet_cidrs_vpc" {
  description = "CIDR blocks for the VPC subnets"
  type        = string
}

variable "subnet_public_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "subnet_private_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}

variable "subnet_private2_cidrs" {
  description = "CIDR blocks for the second set of private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "The availability zones to use"
  type        = list(string)
}

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
}

variable "db_master_username" {
  description = "The master username for the RDS database"
  type        = string
}

variable "db_master_password" {
  description = "The master password for the RDS database"
  type        = string
  sensitive   = true
}

# variable "db_cluster_count" {
#   description = "The number of RDS cluster instances"
#   type        = number
# }

variable "db_cluster_instance_class" {
  description = "The instance class for RDS cluster instances"
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type for autoscaling"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for EC2 instances"
  type        = string
}

variable "desired_capacity" {
  description = "The desired capacity for the autoscaling group"
  type        = number
}

variable "max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
}

variable "min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
}

variable "ec2_key_pair" {
  description = "The EC2 key pair name"
  type        = string
}

variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "app_prefix" {
  description = "The prefix for the application"
  type        = string
}

# # Define variables for bucket names and project prefix
# variable "partneraX-admin-ui" {
#   description = "The name of the admin UI S3 bucket"
# }

# variable "partneraX-client-ui" {
#   description = "The name of the client UI S3 bucket"
# }

# variable "partneraX-landing-ui" {
#   description = "The name of the landing UI S3 bucket"
# }

variable "bastion_ami_id" {
  description = "The AMI ID for EC2 instances"
  type        = string
}

variable "bastion_instance_type" {
  description = "The AMI ID for EC2 instances"
  type        = string
}

variable "certificate_arn" {
  description = "Certificate arn url"
  type = string
}

variable "cloudfront_acm_certificate" {
  description = "Certificate arn url"
  type = string
}

variable "environment" {
  description = "Environment in which the script is run. Eg: dev, dev, etc"
  type        = string
}

variable "build_projects" {
  description = "Tags to be attached to the CodePipeline"
  type        = list(string)
}

variable "builder_compute_type" {
  description = "Relative path to the Apply and Destroy build spec file"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
}

variable "builder_image" {
  description = "Docker Image to be used by codebuild"
  type        = string
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
}

variable "builder_type" {
  description = "Type of codebuild run environment"
  type        = string
  default     = "LINUX_CONTAINER"
}

variable "builder_image_pull_credentials_type" {
  description = "Image pull credentials type used by codebuild project"
  type        = string
  default     = "CODEBUILD"
}

variable "build_project_source" {
  description = "aws/codebuild/standard:4.0"
  type        = string
  default     = "CODEPIPELINE"
}

variable "create_new_role" {
  description = "Whether to create a new IAM Role. Values are true or false. Defaulted to true always."
  type        = bool
  default     = true
}

variable "source_repo_name" {
  description = "Source repo name of the github repository"
  type        = string
}

variable "source_repo_branch" {
  description = "Source repo name of the github repository"
  type        = string
}

variable "codepipeline_iam_role_name" {
  description = "Name of the IAM role to be used by the Codepipeline"
  type        = string
  default     = "codepipeline-role"
}

variable "github_oauth_token" {
  description = "Default branch in the Source repo for which CodePipeline needs to be configured"
  type        = string
}

# variable "github_user" {
#   description = "S3 bucket name to be used for storing the artifacts"
#   type        = string
# }

variable "github_owner_name" {
  description = "S3 bucket name to be used for storing the artifacts"
  type        = string
}


variable "stage_input" {
  description = "Tags to be attached to the CodePipeline"
  type        = list(map(any))
}

# variable "connection_id" {
#   description = "The ID of the CodeStar connection"
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

variable "translation_logging_bucket_name" {
  description = "The name of the S3 bucket for CloudFront logging."
  type        = string
}

variable "s3_translation_bucket_name" {
  description = "The name of the S3 bucket for CloudFront logging."
  type        = string
}

variable "ec2_tag_value" {
  description = "The tag value of the ec2 for CodeDeploy"
  type        = string
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key"
  type        = string
}

variable "secret_name" {
  description = "The secret name of the db"
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

variable "webapp_logging_bucket_name" {
  description = "The name of the S3 bucket for CloudFront logging."
  type        = string
}

variable "s3_adstar_bucket_name" {
  description = "The name of the S3 bucket used as the origin."
  type        = string
}
variable "adstar_aliases" {
  description = "The aliases for the CloudFront distribution."
  type        = list(string)
}

variable "adstar_logging_bucket_name" {
  description = "The name of the S3 bucket for CloudFront logging."
  type        = string
}

variable "s3_translate_ui_bucket_name" {
  description = "The name of the S3 bucket used as the origin."
  type        = string
}

variable "translate_ui_logging_bucket_name" {
  description = "The name of the S3 bucket for CloudFront logging."
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