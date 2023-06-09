variable "static_website"  {
  description = "create/conf static website"
  type = object({
      dns = object({
        zone_id = string
      })
      description = string
      error_page = string
      index_page = string
      name = string
  })
}

variable "log"  {
  description = "cloud front log"
  type = object({
    bucket = object({
      domain_name = string
      arn = string
      id = string
    })
  })
}
