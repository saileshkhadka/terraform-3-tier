#do not commit this file this is just a test file so commited 


region                = "eu-west-1"
profile               = ""
access_key            = ""
secret_key            = ""
VPC_name              = "partneraX-vpc"
subnet_cidrs_vpc      = "10.0.0.0/16"
subnet_public_cidrs   = ["10.0.2.0/24", "10.0.4.0/24", "10.0.6.0/24"]
subnet_private_cidrs  = ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
subnet_private2_cidrs = ["10.0.7.0/24", "10.0.9.0/24", "10.0.11.0/24"]
availability_zones    = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
db_name               = ""
db_master_username    = ""
db_master_password    = ""
# db_cluster_count      = 1
db_cluster_instance_class = "db.serverless"
secret_name = ""
instance_type         = "t4g.medium"
bastion_ami_id        = ""
bastion_instance_type = "t4g.small"
ami_id                = ""
desired_capacity      = 1
max_size              = 3
min_size              = 1
ec2_key_pair          = ""
ec2_tag_value         = ""
app_name              = ""
app_prefix            = ""
certificate_arn       = "" 
cloudfront_acm_certificate    = ""
cloudfront_cache_policy_id  = ""
cloudfront_origin_request_policy_id = ""
build_projects        = ["validate", "plan", "apply", "destroy"]
build_project_source  = "CODEPIPELINE"
builder_compute_type  = "BUILD_GENERAL1_SMALL"
builder_image         = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
builder_image_pull_credentials_type = "CODEBUILD"
builder_type           = "LINUX_CONTAINER"
create_new_role       = true
source_repo_name      = ""
github_owner_name     = ""
codepipeline_iam_role_name = ""
github_oauth_token    = ""
environment           = "dev"
source_repo_branch    = "test-sailesh"
kms_key_arn = ""

stage_input = [
  { name = "validate", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "SourceOutput", output_artifacts = "ValidateOutput" },
  { name = "plan", category = "Test", owner = "AWS", provider = "CodeBuild", input_artifacts = "ValidateOutput", output_artifacts = "PlanOutput" },
  { name = "apply", category = "Build", owner = "AWS", provider = "CodeBuild", input_artifacts = "PlanOutput", output_artifacts = "ApplyOutput" },
  # { name = "destroy", category = "Build", owner = "AWS", provider = "CodeBuild", input_artifacts = "ApplyOutput", output_artifacts = "DestroyOutput" }
]


