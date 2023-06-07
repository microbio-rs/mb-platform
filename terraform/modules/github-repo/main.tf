resource "github_repository" "repo" {
  name             = var.repo_name
  description      = var.repo_description
  visibility       = var.repo_public == true ? "public" : "private"
  has_wiki         = false
  license_template = var.license
  auto_init        = var.init
}

resource "github_branch_default" "default" {
  repository = github_repository.repo.name
  branch     = var.repo_default_branch
  rename     = true
}
