# Origin Access Control (OAC) für die S3 Bucket (gewährt Cloudfront Zugriff auf die Bucket, denn diese ist nicht öffentlich zugreifbar)
resource "aws_cloudfront_origin_access_control" "current" {
  name                              = "OAC ${aws_s3_bucket.static_website.bucket}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Definition der Cloudfront Distribution
resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true

  # Bei Aufruf der Domain wird index.html ausgeliefert
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  aliases = [
    var.website_domain,
    "www.${var.website_domain}"
  ]

  origin {
    domain_name              = aws_s3_bucket.static_website.bucket_regional_domain_name
    origin_id                = "${var.website_bucket_name}-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.current.id
  }

  default_cache_behavior {
    target_origin_id       = "${var.website_bucket_name}-origin"
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.cert_validation.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}