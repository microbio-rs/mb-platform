resource "aws_route53_zone" "dns" {
  name             = var.dns.domain
  comment = var.dns.description
}
