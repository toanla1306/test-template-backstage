module "codebuild" {
  source = "./modules/codebuild"
  name = local.name
  S3BucketName = var.S3BucketName
}