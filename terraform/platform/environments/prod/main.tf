#------------------------------------------------------------------------------
# VPC
#------------------------------------------------------------------------------
# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"

#   name = "microbio-rs"
#   cidr = "10.0.0.0/16"

#   azs             = ["eu-east-1a", "eu-east-1b", "eu-east-1c"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#   enable_nat_gateway = true
#   enable_vpn_gateway = true

#   tags = {
#     Terraform = "true"
#     Environment = "dev"
#   }
# }

#------------------------------------------------------------------------------
# CLOUDFRONT (CDN)
#------------------------------------------------------------------------------
# module "cdn" {
#   source = "terraform-aws-modules/cloudfront/aws"

#   aliases = ["cdn.example.com"]

#   comment             = "My awesome CloudFront"
#   enabled             = true
#   is_ipv6_enabled     = true
#   price_class         = "PriceClass_All"
#   retain_on_delete    = false
#   wait_for_deployment = false

#   create_origin_access_identity = true
#   origin_access_identities = {
#     s3_bucket_one = "My awesome CloudFront can access"
#   }

#   logging_config = {
#     bucket = "logs-my-cdn.s3.amazonaws.com"
#   }

#   origin = {
#     something = {
#       domain_name = "something.example.com"
#       custom_origin_config = {
#         http_port              = 80
#         https_port             = 443
#         origin_protocol_policy = "match-viewer"
#         origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
#       }
#     }

#     s3_one = {
#       domain_name = "my-s3-bycket.s3.amazonaws.com"
#       s3_origin_config = {
#         origin_access_identity = "s3_bucket_one"
#       }
#     }
#   }

#   default_cache_behavior = {
#     target_origin_id           = "something"
#     viewer_protocol_policy     = "allow-all"

#     allowed_methods = ["GET", "HEAD", "OPTIONS"]
#     cached_methods  = ["GET", "HEAD"]
#     compress        = true
#     query_string    = true
#   }

#   ordered_cache_behavior = [
#     {
#       path_pattern           = "/static/*"
#       target_origin_id       = "s3_one"
#       viewer_protocol_policy = "redirect-to-https"

#       allowed_methods = ["GET", "HEAD", "OPTIONS"]
#       cached_methods  = ["GET", "HEAD"]
#       compress        = true
#       query_string    = true
#     }
#   ]

#   viewer_certificate = {
#     acm_certificate_arn = "arn:aws:acm:us-east-1:135367859851:certificate/1032b155-22da-4ae0-9f69-e206f825458b"
#     ssl_support_method  = "sni-only"
#   }
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

# module "git" {
#   owner            = var.owner
#   source           = "../../modules/github-repo"
#   repo_name        = var.repo_name
#   repo_description = "simple test"
#   repo_public      = true
# }


