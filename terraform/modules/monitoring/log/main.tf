data "aws_caller_identity" "current" {}

###############################################################################
# Bucket Log
###############################################################################

resource "aws_s3_bucket" "example" {
  bucket = var.bucket.name
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id

  rule {
    object_ownership = var.bucket.ownership
  }

  depends_on = [
    aws_s3_bucket.example
  ]
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.example.id
  acl    = "private"
}
