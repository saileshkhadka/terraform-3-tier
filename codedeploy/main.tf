resource "aws_codedeploy_app" "app" {
  name = "${var.app_name}-app"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name               = aws_codedeploy_app.app.name
  deployment_group_name = "${var.app_name}-deployment-group"
  service_role_arn       = var.codedeploy_role_arn 
  deployment_style {
    deployment_type = "IN_PLACE"
  }

  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  ec2_tag_filter {
    key   = "Name"
    value = var.ec2_tag_value
    type  = "KEY_AND_VALUE"
  }
}