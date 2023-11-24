resource "aws_codebuild_project" "my_codebuild_project" {
  name          = "MyCodeBuildProject"
  description   = "My CodeBuild Project"
  build_timeout = "15"
  service_role  = aws_iam_role.codebuild_role.arn

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
  }

  source {
    type = "CODEPIPELINE"
    # location = aws_s3_bucket_object.source_code.bucket
    # location = var.S3BucketName
    buildspec = "buildspec.yml"  # Replace with the path to your buildspec file
  }

  artifacts {
    type = "CODEPIPELINE"
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

resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess_codebuild" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_policy" "codebuild_policy" {
  name = "CodeBuildPolicy"

  policy = jsonencode(
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds",
        "secretsmanager:ListSecrets"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:CreateReportGroup",
        "codebuild:CreateReport",
        "codebuild:UpdateReport",
        "codebuild:BatchPutTestCases",
        "codebuild:BatchPutCodeCoverages"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [ "ecr:*" ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [ "s3:*" ],
      "Resource": "*"
    }
  ]
})
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  policy_arn = aws_iam_policy.codebuild_policy.arn
  role       = aws_iam_role.codebuild_role.name
}