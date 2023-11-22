terraform {
   backend "s3" {
     bucket = "demo-project-toanla"
     key    = "codepipeline/terraform.tfstate"
     region = "us-east-1"
   }
 }

 provider "aws" {
   region = "us-east-1"

   default_tags {
     tags = local.tags
     
   }
 }