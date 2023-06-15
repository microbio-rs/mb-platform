include "root" {
  path   = find_in_parent_folders("root-config.hcl")
  expose = true
}

include "stage" {
  path   = find_in_parent_folders("stage.hcl")
  expose = true
}

locals {
  # merge tags
  local_tags = {
    "Domain" = "microbio.rs",
  }

  tags = merge(include.root.locals.root_tags, include.stage.locals.tags, local.local_tags)
}

generate "provider_global" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {}
  required_version = "${include.root.locals.version_terraform}"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "${include.root.locals.version_provider_aws}"
    }
  }
}

provider "aws" {
  region = "${include.root.locals.region}"
}
EOF
}

inputs = {
  vpc = {
      name = "microbio-vpc"
      cidr = "10.0.0.0/16"
      zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
      privates = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      publics = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
      has_nat = false
      has_vpn = false
      tags = locals.tags
  }
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/..//terraform/modules/network/vpc"
}
