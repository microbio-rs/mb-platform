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
    "GitProvider" = "Github",
    "GitRepository" = "https://github.com/microbio.rs/blog",
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
    github = {
      source  = "integrations/github"
      version = "${include.root.locals.version_provider_github}"
    }
  }
}

provider "aws" {
  region = "${include.root.locals.region}"
}
provider "github" {
  owner = "${include.root.locals.github_owner}"
}
EOF
}

// Github
# dependency "dns" {
#   config_path = "${get_parent_terragrunt_dir("root")}/shared/${include.stage.locals.stage}/network/dns"
# }

inputs = {
  log = {
    bucket = {
      domain_name = dependency.log.outputs.domain_name
      arn = dependency.log.outputs.arn
      id = dependency.log.outputs.id
    }
  }
}

// Cluster + Service?
terraform {
  source = "${get_parent_terragrunt_dir("root")}/..//terraform/modules/static-website"
}
