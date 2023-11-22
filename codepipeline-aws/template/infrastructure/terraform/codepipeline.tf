module "codepipeline" {
  source = "./modules/codepipeline"
  name = local.name
  S3BucketName = "test123-outputbucket-tkiodwbo4s8q"
  S3ObjectKey  = "quickstart-git2s3/functions/packages/GitPullS3/lambda.zip"
  ProjectName = module.codebuild.ProjectName
}