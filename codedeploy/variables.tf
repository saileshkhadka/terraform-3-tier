variable "app_name" {
  description = "Unique name for this project"
  type        = string
}

variable "codedeploy_role_arn" {
  description = "The ARN of the IAM role used by CodeDeploy"
  type        = string
}

variable "ec2_tag_value" {
  description = "The tag value of the ec2 for CodeDeploy"
  type        = string
}