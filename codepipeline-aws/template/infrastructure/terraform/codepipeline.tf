module "codepipeline" {
  source = "./modules/codepipeline"
  name = local.name
  S3BucketName = "test123-outputbucket-tkiodwbo4s8q"
  S3ObjectKey  = "quickstart-git2s3/functions/packages/GitPullS3/lambda.zip"
  ProjectName = module.codebuild.ProjectName
  
  # application_name = module.codedeploy.deploy_application_name
  # deployment_group_name = module.codedeploy.application_deployment_group_name
}