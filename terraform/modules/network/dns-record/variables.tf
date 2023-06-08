variable "record"  {
  description = "dns record"
  type = object({
      name = string
      type    = string
      ttl     = string
      records = list(string)
  })
}
