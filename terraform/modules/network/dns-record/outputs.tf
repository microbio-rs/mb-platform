output "dns_name" {
  description = "record dns name"
  value       = aws_route53_record.record.name
}
