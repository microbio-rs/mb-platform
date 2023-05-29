output "repo_url" {
  description = "repo http url"
  value       = github_repository.repo.full_name
}

output "repo_ssh" {
  description = "repo ssh clone url"
  value       = github_repository.repo.ssh_clone_url
}

output "repo_http" {
  description = "repo http clone url"
  value       = github_repository.repo.http_clone_url
}

output "repo_id" {
  description = "repo id"
  value       = github_repository.repo.repo_id
}
