resource "aws_codebuild_project" "my_codebuild_project" {
  name          = "MyCodeBuildProject"
  description   = "My CodeBuild Project"
  build_timeout = "5"
  service_role  = aws_iam_role.codebuild_role.arn

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
  }

  source {
    type = "S3"
    # location = aws_s3_bucket_object.source_code.bucket
    location = var.S3BucketName
    buildspec = "buildspec.yml"  # Replace with the path to your buildspec file
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }
}

resource "aws_iam_role" "codebuild_role" {
  name = "CodeBuildRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}