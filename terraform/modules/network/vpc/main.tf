###############################################################################
# VPC
###############################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc.name
  cidr = var.vpc.cidr

  azs             = var.vpc.zones
  private_subnets = var.vpc.private
  public_subnets  = var.vpc.public

  enable_nat_gateway = var.vpc.has_nat
  enable_vpn_gateway = var.vpc.has_vpn

  tags = var.vpc.tags
}
