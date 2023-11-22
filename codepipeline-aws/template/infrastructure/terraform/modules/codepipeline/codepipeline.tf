resource "aws_s3_bucket" "pipeline_artifacts" {
  bucket = "my-pipeline-artifacts-bucket"  # Replace with a unique S3 bucket name
}

resource "aws_codepipeline" "my_codepipeline" {
  name     = "MyCodePipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.pipeline_artifacts.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"  # Change this based on your source provider
      version          = "1"
      output_artifacts = ["SourceOutput"]

      configuration = {
        S3Bucket        = var.S3BucketName
        S3ObjectKey     = var.S3ObjectKey
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "BuildAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = ["BuildOutput"]

      configuration = {
        ProjectName = var.ProjectName
      }
    }
  }

  # stage {
  #   name = "Deploy"

  #   action {
  #     name             = "DeployAction"
  #     category         = "Deploy"
  #     owner            = "AWS"
  #     provider         = "ECS"
  #     version          = "1"
  #     input_artifacts  = ["BuildOutput"]

  #     configuration = {
  #       ClusterName        = aws_ecs_cluster.my_cluster.name
  #       ServiceName        = "my-ecs-service"  # Replace with your ECS service name
  #       FileName           = "imagedefinitions.json"
  #       Image1ArtifactName = "BuildOutput::image1"
  #       Image2ArtifactName = "BuildOutput::image2"
  #     }
  #   }
  # }
}

resource "aws_iam_role" "codepipeline_role" {
  name = "CodePipelineRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}