output "id" {
  description = "bucket id"
  value       = aws_s3_bucket.example.id
}

output "arn" {
  description = "bucket arn"
  value       = aws_s3_bucket.example.arn
}

output "domain_name" {
  description = "bucket domain_name"
  value       = aws_s3_bucket.example.bucket_domain_name
}
