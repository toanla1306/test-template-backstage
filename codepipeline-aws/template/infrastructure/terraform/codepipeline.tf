module "codepipeline" {
  source = "./modules/codepipeline"
  name = local.name
  S3BucketName = var.S3BucketName
  S3ObjectKey  = var.S3ObjectKey
  ProjectName = module.codebuild.ProjectName

  # application_name = module.codedeploy.deploy_application_name
  # deployment_group_name = module.codedeploy.application_deployment_group_name
}