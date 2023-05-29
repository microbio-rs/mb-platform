variable "owner" {
  description = "owner"
  type        = string
}

variable "repo_default_branch" {
  description = "default repo branch"
  type        = string
  default     = "master"
}

variable "repo_name" {
  description = "repository name"
  type        = string
}

variable "repo_description" {
  description = "description of repo"
  type        = string
  default     = ""
}

variable "repo_public" {
  description = "if repo is public"
  type        = bool
  default     = true
}