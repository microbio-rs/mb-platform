resource "github_repository" "repo" {
  name             = var.github_repository.name
  description      = var.github_repository.description
  visibility       = var.github_repository.public == true ? "public" : "private"
  has_wiki         = false
  license_template = var.github_repository.license
  auto_init        = var.github_repository.init
}

resource "github_branch" "master" {
  repository = github_repository.repo.name
  branch     = var.github_repository.default_branch
}

resource "github_branch_default" "default" {
  repository = github_repository.repo.name
  branch     = var.github_repository.default_branch
}
