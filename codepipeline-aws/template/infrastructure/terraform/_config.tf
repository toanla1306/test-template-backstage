terraform {
   backend "s3" {
     bucket = "demo-project-toanla"
     key    = "${{ values.name }}/terraform.tfstate"
     region = "${{ values.region }}"
   }
 }

 provider "aws" {
   region = "${{ values.region }}"

   default_tags {
     tags = local.tags
     
   }
 }