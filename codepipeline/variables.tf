variable "app_name" {
  description = "Unique name for this project"
  type        = string
}

variable "source_repo_name" {
  description = "Source repo name of the github repository"
  type        = string
}

variable "source_repo_branch" {
  description = "Default branch in the Source repo for which CodePipeline needs to be configured"
  type        = string
}

variable "github_oauth_token" {
  description = "Default branch in the Source repo for which CodePipeline needs to be configured"
  type        = string
}

variable "github_owner_name" {
  description = "S3 bucket name to be used for storing the artifacts"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name to be used for storing the artifacts"
  type        = string
}

variable "codepipeline_role_arn" {
  description = "ARN of the codepipeline IAM role"
  type        = string
}

variable "kms_key_arn" {
  description = "ARN of KMS key for encryption"
  type        = string
}

variable "tags" {
  description = "Tags to be attached to the CodePipeline"
  type        = map(any)
}

variable "stages" {
  description = "List of Map containing information about the stages of the CodePipeline"
  type        = list(map(any))
}

# variable "terraform_codebuild_project_name" {
#   type = string
# }

# variable "deploy_project_name" {
#   type = string
# }


variable "codedeploy_deployment_group_name" {
  description = "The name of the CodeDeploy deployment group"
  type        = string
}

variable "codedeploy_app_name" {
  description = "The name of the CodeDeploy application"
  type        = string
}