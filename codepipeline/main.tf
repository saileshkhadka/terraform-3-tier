
# resource "aws_codestarconnections_connection" "github_connection" {
#   name          = "github-connection"
#   provider_type = "GitHub"
# }


resource "aws_codepipeline" "terraform_pipeline" {
  name     = "${var.app_name}-pipeline"
  role_arn = var.codepipeline_role_arn
  tags     = var.tags

  artifact_store {
    location = var.s3_bucket_name
    type     = "S3"
    encryption_key {
      id   = var.kms_key_arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      version          = 1
      run_order        = 1
      provider         = "GitHub"
      output_artifacts = ["SourceOutput"]
      configuration = {
        Owner            = var.github_owner_name
        Repo             = var.source_repo_name
        Branch           = var.source_repo_branch
        OAuthToken       = var.github_oauth_token
        PollForSourceChanges = "false"
      }
    }
  }

  # stage {
  #   name = "Build"

  #   action {
  #     name             = "Build"
  #     category         = "Build"
  #     owner            = "AWS"
  #     provider         = "CodeBuild"
  #     input_artifacts  = ["SourceOutput"]
  #     output_artifacts = ["BuildOutput"]
  #     version          = "1"

  #     configuration = {
  #       # ProjectName = aws_codebuild_project.terraform_codebuild_project.name[0]
  #       ProjectName = var.terraform_codebuild_project_name
  #     }
  #     # configuration = {
  #     #   Owner            = var.github_user
  #     #   Repo             = var.source_repo_name
  #     #   Branch           = var.source_repo_branch
  #     #   OAuthToken       = var.github_oauth_token
  #     # }
  #   }
  # }

  # stage {
  #   name = "Deploy"

  #   action {
  #     name             = "Deploy"
  #     category         = "Build"
  #     owner            = "AWS"
  #     provider         = "CodeBuild"
  #     input_artifacts  = ["SourceOutput"]
  #     output_artifacts = null
  #     version          = "1"

  #     configuration = {
  #       ProjectName = var.deploy_project_name
  #     }

  #   }
  # }

  stage {
    name = "Deploy"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "CodeDeploy"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = null
      version          = "1"

      configuration = {
        ApplicationName     = var.codedeploy_app_name
        DeploymentGroupName = var.codedeploy_deployment_group_name
      }
    }
  }

  # dynamic "stage" {
  #   for_each = var.stages

  #   content {
  #     name = "Stage-${stage.value["name"]}"
  #     action {
  #       category         = stage.value["category"]
  #       name             = "Action-${stage.value["name"]}"
  #       owner            = stage.value["owner"]
  #       provider         = stage.value["provider"]
  #       input_artifacts  = [stage.value["input_artifacts"]]
  #       output_artifacts = [stage.value["output_artifacts"]]
  #       version          = "1"
  #       run_order        = index(var.stages, stage.value) + 2

  #       configuration = {
  #         ProjectName = stage.value["provider"] == "CodeBuild" ? "${var.app_name}-${stage.value["name"]}" : null
  #       }
  #     }
  #   }
  # }
}
