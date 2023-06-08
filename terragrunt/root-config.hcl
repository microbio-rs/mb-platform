locals {
  region = "us-east-1"
  github_owner = "microbio-rs"

  version_terraform    = "=1.4.6"
  version_terragrunt   = "=0.45.9"
  version_provider_aws = "=5.1.0"
  version_provider_github = "=5.0"

  root_tags = {
    organization = "microbio-rs"
  }
}

generate "provider_global" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = "${local.version_terraform}"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "${local.version_provider_aws}"
    }
  }
}

provider "aws" {
  region = "${local.region}"
}
EOF
}


remote_state {
  backend = "s3"
  config = {
    bucket         = "microbio-terraform-state"
    dynamodb_table = "microbio-terraform-state-lock"
    encrypt        = true
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
  }
}
