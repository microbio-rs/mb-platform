module "git" {
  owner            = var.owner
  source           = "../../modules/github-repo"
  repo_name        = var.repo_name
  repo_description = "simple test"
  repo_public      = true
}
