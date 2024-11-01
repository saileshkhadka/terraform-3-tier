provider "aws" {
  region     = var.region
  profile    = var.profile
  access_key = var.access_key
  secret_key = var.secret_key
  alias  = "replication"
}

terraform {
  backend "s3" {
    bucket  = "partneraX-backend-deploy"
    encrypt = true
    key     = "dev_main.tfstate" 
    region  = "eu-west-1"
    profile = "partneraX"
  }
}

module "vpc" {
  source = "./vpc"

  vpc_name              = var.VPC_name
  subnet_cidrs_vpc      = var.subnet_cidrs_vpc
  subnet_public_cidrs   = var.subnet_public_cidrs
  subnet_private_cidrs  = var.subnet_private_cidrs
  subnet_private2_cidrs = var.subnet_private2_cidrs
  availability_zones    = var.availability_zones
}

module "securitygroups" {
  source = "./securitygroups"

  vpc_id                 = module.vpc.vpc_id
  load_balancer_sg_id    = module.securitygroups.load_balancer_sg_id
  bastion_sg_id          = module.bastionhost.bastion_sg_id
  subnet_cidrs_vpc       = var.subnet_cidrs_vpc
}

module "rds" {
  source = "./rds"

  db_name                   = var.db_name
  db_master_username        = var.db_master_username
  db_master_password        = var.db_master_password
  # db_cluster_count          = var.db_cluster_count
  db_cluster_instance_class = var.db_cluster_instance_class
  vpc_id                    = module.vpc.vpc_id
  private_subnet_ids        = module.vpc.private_subnet_ids
  bastion_sg                = module.securitygroups.bastion_sg_id
  db_sg_id                  = module.securitygroups.db_sg_id
  secret_name               = var.secret_name
}

module "loadbalancer" {
  source = "./loadbalancer"

  vpc_id        = module.vpc.vpc_id
  public_subnet_ids    = module.vpc.public_subnets
  instance_ids  = module.autoscaling.instance_ids
  asg_name      = module.autoscaling.asg_name
  load_balancer_sg_id = module.securitygroups.load_balancer_sg_id
  certificate_arn       = var.certificate_arn
}

module "autoscaling" {
  source = "./autoscaling"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids_ec2 = module.vpc.private_subnet_ids_ec2 
  instance_type      = var.instance_type
  ami_id             = var.ami_id
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size
  ec2_key_pair       = var.ec2_key_pair
  app_name           = var.app_name
  app_prefix         = var.app_prefix
  load_balancer_sg_id    = module.securitygroups.load_balancer_sg_id
  target_group_arns  = [module.loadbalancer.target_group_arn]
  bastion_sg         = module.securitygroups.bastion_sg_id
  db_sg_id           = module.securitygroups.db_sg_id
  instance_sg_id     = module.securitygroups.instance_sg_id
  kms_key_arn        = var.kms_key_arn
}

module "s3" {
  source = "./s3"

  # partneraX-admin-ui          = var.partneraX-admin-ui
  # partneraX-client-ui         = var.partneraX-client-ui
  # partneraX-landing-ui        = var.partneraX-landing-ui

  app_name              = var.app_name
  kms_key_arn           = module.kms.arn
  codepipeline_role_arn = module.iam.role_arn
  photos_logging_bucket_name   = var.photos_logging_bucket_name
  cloudfront_photos_distribution_id = module.cloudfront.cloudfront_photos_distribution_id
  cloudfront_translation_distribution_id = module.cloudfront.cloudfront_translation_distribution_id
  translation_logging_bucket_name = var.translation_logging_bucket_name
  webapp_logging_bucket_name = var.webapp_logging_bucket_name
  adstar_logging_bucket_name = var.adstar_logging_bucket_name
  cloudfront_adstar_distribution_id = module.cloudfront.cloudfront_adstar_distribution_id
  cloudfront_webapp_distribution_id = module.cloudfront.cloudfront_webapp_distribution_id
  cloudfront_translate_ui_distribution_id  = module.cloudfront.cloudfront_translate_ui_distribution_id
  translate_ui_logging_bucket_name = var.translate_ui_logging_bucket_name
  cloudfront_sso_distribution_id = module.cloudfront.cloudfront_sso_distribution_id
  tags = {
    Project_Name = var.app_name
    Environment  = var.environment
  }
}

module "cloudfront" {
  source = "./cloudfront"
  photos_aliases     = var.photos_aliases
  translation_aliases = var.translation_aliases
  photos_logging_bucket_name = var.photos_logging_bucket_name
  s3_photos_bucket_name = var.s3_photos_bucket_name
  s3_translation_bucket_name = var.s3_translation_bucket_name
  aws_region      = var.region
  cloudfront_acm_certificate = var.cloudfront_acm_certificate
  adstar_aliases = var.adstar_aliases
  webapp_aliases = var.webapp_aliases
  s3_adstar_bucket_name   = var.s3_adstar_bucket_name
  s3_webapp_bucket_name = var.s3_webapp_bucket_name
  s3_translate_ui_bucket_name = var.s3_translate_ui_bucket_name
  translate_ui_aliases = var.translate_ui_aliases
  cloudfront_cache_policy_id = var.cloudfront_cache_policy_id
  cloudfront_origin_request_policy_id = var.cloudfront_origin_request_policy_id
  s3_sso_bucket_name = var.s3_sso_bucket_name
  sso_aliases = var.sso_aliases


}


module "bastionhost" {
  source = "./bastionhost"

  vpc_id                 = module.vpc.vpc_id
  public_subnet_ids      = module.vpc.public_subnets
  ec2_key_pair           = var.ec2_key_pair
  bastion_ami_id         = var.bastion_ami_id
  bastion_instance_type  = var.bastion_instance_type
  db_sg_id               = module.securitygroups.db_sg_id
  instance_sg_id         = module.securitygroups.instance_sg_id
  bastion_sg_id          = module.securitygroups.bastion_sg_id
}

#uncomment if you need codebuild configuration
# module "codebuild" {
#   source = "./codebuild"

#   app_name                            = var.app_name
#   role_arn                            = module.iam.role_arn
#   s3_bucket_name                      = module.s3.bucket
#   build_projects                      = var.build_projects
#   build_project_source                = var.build_project_source
#   builder_compute_type                = var.builder_compute_type
#   builder_image                       = var.builder_image
#   builder_image_pull_credentials_type = var.builder_image_pull_credentials_type
#   builder_type                        = var.builder_type
#   kms_key_arn                         = module.kms.arn
#   source_repo_name                    = var.source_repo_name
#   github_owner_name                   = var.github_owner_name
#   tags = {
#     Project_Name = var.app_name
#     Environment  = var.environment
#   }
# }

module "kms" {
  source                = "./kms"

  codepipeline_role_arn = module.iam.role_arn
  tags = {
    Project_Name = var.app_name
    Environment  = var.environment
  }

}

module "iam" {
  source                     = "./iam"
  app_name                   = var.app_name
  create_new_role            = var.create_new_role
  codepipeline_iam_role_name = var.create_new_role == true ? "${var.app_name}-codepipeline-role" : var.codepipeline_iam_role_name
  source_repository_name     = var.source_repo_name
  kms_key_arn                = module.iam.role_arn
  s3_bucket_arn              = module.s3.arn
  # connection_id              = var.connection_id
  tags = {
    Project_Name = var.app_name
    Environment  = var.environment
  }
}

module "codedeploy" {
  source = "./codedeploy"
  app_name = var.app_name 
  codedeploy_role_arn = module.iam.codedeploy_role_arn
  ec2_tag_value = var.ec2_tag_value
}

module "codepipeline" {
  depends_on = [
    # module.codebuild,
    module.s3
  ]
  source = "./codepipeline"

  app_name              = var.app_name
  source_repo_name      = var.source_repo_name
  source_repo_branch    = var.source_repo_branch
  s3_bucket_name        = module.s3.bucket
  codepipeline_role_arn = module.iam.role_arn
  stages                = var.stage_input
  kms_key_arn           = module.kms.arn
  github_oauth_token    = var.github_oauth_token
  # github_user           = var.github_user
  github_owner_name     = var.github_owner_name
  # terraform_codebuild_project_name = module.codebuild.terraform_codebuild_project_name
  # deploy_project_name              = module.codebuild.deploy_project_name
  codedeploy_app_name              = module.codedeploy.codedeploy_app_name
  codedeploy_deployment_group_name = module.codedeploy.codedeploy_deployment_group_name
  tags = {
    Project_Name = var.app_name
    Environment  = var.environment
  }
  
}