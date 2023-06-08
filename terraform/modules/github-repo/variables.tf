variable "github_repository"  {
  type = object({
      name             = string
      description      = string
      public = bool
      has_wiki         = bool
      license = string
      init        = bool
      default_branch = string
  })
}
