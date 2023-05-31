#------------------------------------------------------------------------------
# VPC
#------------------------------------------------------------------------------
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "microbio-rs"
  cidr = "10.0.0.0/16"

  azs             = ["eu-east-1a", "eu-east-1b", "eu-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

# module "git" {
#   owner            = var.owner
#   source           = "../../modules/github-repo"
#   repo_name        = var.repo_name
#   repo_description = "simple test"
#   repo_public      = true
# }


#------------------------------------------------------------------------------
# DOCKER ECR
#------------------------------------------------------------------------------
# module "ecr" {
#   source = "terraform-aws-modules/ecr/aws"

#   repository_name = "private-example"

#   repository_read_write_access_arns = ["arn:aws:iam::012345678901:role/terraform"]

#   repository_lifecycle_policy = jsonencode({
#     rules = [
#       {
#         rulePriority = 1,
#         description  = "Keep last 30 images",
#         selection = {
#           tagStatus     = "tagged",
#           tagPrefixList = ["v"],
#           countType     = "imageCountMoreThan",
#           countNumber   = 30
#         },
#         action = {
#           type = "expire"
#         }
#       }
#     ]
#   })

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }

# }
