locals {
  stage = "prod"

  tags = {
    environment = local.stage
    developer   = "mbsd"
  }
}
