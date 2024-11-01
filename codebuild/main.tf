# resource "aws_codebuild_project" "terraform_codebuild_project" {

#   count = length(var.build_projects)

#   name           = "${var.app_name}-${var.build_projects[count.index]}"
#   service_role   = var.role_arn
#   encryption_key = var.kms_key_arn
#   tags           = var.tags
#   artifacts {
#     type = var.build_project_source
#   }
#   environment {
#     compute_type                = var.builder_compute_type
#     image                       = var.builder_image
#     type                        = var.builder_type
#     privileged_mode             = true
#     image_pull_credentials_type = var.builder_image_pull_credentials_type
#   }
#   logs_config {
#     cloudwatch_logs {
#       status = "ENABLED"
#     }
#   }
#   source {
#     type      = var.build_project_source
#     # buildspec = "./templates/buildspec_${var.build_projects[count.index]}.yml"
#     buildspec = "./templates/devspec.yml"
#   }
# }



# #need if use codebuild
# resource "aws_codebuild_project" "deploy_project" {
#   name           = "${var.app_name}-deploy"
#   service_role   = var.role_arn
#   encryption_key = var.kms_key_arn
#   tags           = var.tags

#   artifacts {
#     type = "NO_ARTIFACTS"
#   }

#   environment {
#     compute_type                = var.builder_compute_type
#     image                       = var.builder_image
#     type                        = var.builder_type
#     privileged_mode             = true
#     image_pull_credentials_type = var.builder_image_pull_credentials_type
#   }

#   source {
#     type        = "GITHUB"
#     location      = "https://github.com/${var.github_owner_name}/${var.source_repo_name}.git"
#     buildspec = file("./templates/appspec.yml") 
#   }
# }