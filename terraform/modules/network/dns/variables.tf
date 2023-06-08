variable "dns"  {
  type = object({
      domain = string
      description = string
  })
}

variable "record"  {
  default = null
  type = object({
      prefix = string
  })
}
