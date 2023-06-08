resource "aws_route53_record" "record" {
  zone_id = var.record.zone_id
  name    = var.record.name
  type    = var.record.type
  ttl     = var.record.ttl
  records = var.record.values
}
