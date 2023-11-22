module "codebuild" {
  source = "./modules/codebuild"
  name = local.name
  S3BucketName = "test123-outputbucket-tkiodwbo4s8q/test"
}