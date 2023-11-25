locals {
  account_id = data.aws_caller_identity.current.account_id
  name = "${{ values.name }}"
  region = "us-east-1"
  tags = {
    Name = local.name
    Terraform = "true"
  }
}