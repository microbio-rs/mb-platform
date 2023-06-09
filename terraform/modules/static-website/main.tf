###############################################################################
# Github repository
###############################################################################
module "repo" {
  source = "../github-repo"

  github_repository = {
    name           = var.static_website.name
    description    = var.static_website.description
    public         = true
    has_wiki       = false
    license        = ""
    init           = true
    default_branch = "master"
  }
}

###############################################################################
# ACM (Certificate Manager)
###############################################################################
resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.static_website.name}.${data.aws_route53_zone.dns.name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
  depends_on = [
    aws_route53_record.cert_validation
  ]
}

################################################################################
## Route53 (Dns record for certificate validation)
################################################################################
data "aws_route53_zone" "dns" {
  zone_id = var.static_website.dns.zone_id
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.dns.zone_id

  depends_on = [
    aws_acm_certificate.cert
  ]
}


###############################################################################
# S3 Bucket and Website configuration
###############################################################################

resource "aws_s3_bucket" "b" {
  bucket        = "${var.static_website.name}.${data.aws_route53_zone.dns.name}"
  force_destroy = true

  depends_on = [
    aws_acm_certificate_validation.example
  ]
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.b.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "mybucket" {
  bucket = aws_s3_bucket.b.id
  policy = data.aws_iam_policy_document.s3_policy.json

  # depends_on = [
  #   aws_cloudfront_origin_access_control.default
  # ]
}

###############################################################################
# ACL S3 Bucket for log
################################################################################

data "aws_iam_policy_document" "blog_s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.log.bucket.arn}/${var.static_website.name}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.example.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${var.log.bucket.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.example.iam_arn}"]
    }
  }
}

resource "aws_s3_bucket_policy" "blog" {
  bucket = var.log.bucket.id
  policy = data.aws_iam_policy_document.blog_s3_policy.json
}

###############################################################################
# CloudFront (CDN)
################################################################################

locals {
  blog_s3_origin_id = "blog"
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = var.static_website.name
  description                       = var.static_website.description
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_origin_access_identity" "example" {
  comment = "Some comment"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.b.bucket_regional_domain_name
    # origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = local.blog_s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.example.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = var.log.bucket.domain_name
    prefix          = var.static_website.name
  }

  aliases = ["${var.static_website.name}.${data.aws_route53_zone.dns.name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.blog_s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # # Cache behavior with precedence 0
  # ordered_cache_behavior {
  #   path_pattern     = "/content/immutable/*"
  #   allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #   cached_methods   = ["GET", "HEAD", "OPTIONS"]
  #   target_origin_id = local.s3_origin_id

  #   forwarded_values {
  #     query_string = false
  #     headers      = ["Origin"]

  #     cookies {
  #       forward = "none"
  #     }
  #   }

  #   min_ttl                = 0
  #   default_ttl            = 86400
  #   max_ttl                = 31536000
  #   compress               = true
  #   viewer_protocol_policy = "redirect-to-https"
  # }

  # Cache behavior with precedence 1
  # ordered_cache_behavior {
  #   path_pattern     = "/content/*"
  #   allowed_methods  = ["GET", "HEAD", "OPTIONS"]
  #   cached_methods   = ["GET", "HEAD"]
  #   target_origin_id = local.s3_origin_id

  #   forwarded_values {
  #     query_string = false

  #     cookies {
  #       forward = "none"
  #     }
  #   }

  # min_ttl                = 0
  # default_ttl            = 3600
  # max_ttl                = 86400
  # compress               = true
  # viewer_protocol_policy = "redirect-to-https"
  # }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
  }

  depends_on = [aws_acm_certificate.cert]
}

################################################################################
# Route53 (Dns record for certificate validation)
###############################################################################

resource "aws_route53_record" "record" {
  zone_id = var.static_website.dns.zone_id
  name    = "${var.static_website.name}.${data.aws_route53_zone.dns.name}"
  type    = "A"

  alias {
    name                   = replace(aws_cloudfront_distribution.s3_distribution.domain_name, "/[.]$/", "")
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }

  depends_on = [aws_cloudfront_distribution.s3_distribution]
}

###############################################################################
# Lambda Edge - Add security headers to response
###############################################################################

###############################################################################
# WAF (Web application firewall)
###############################################################################
