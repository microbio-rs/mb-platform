variable "vpc"  {
  type = object({
      name = string
      cidr = string
      zones = list(string)
      privates = list(string)
      publics = list(string)
      has_nat = bool
      has_vpn = bool
      tags = map()
  })
}
