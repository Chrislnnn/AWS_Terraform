# SSL-Zertifikat im AWS Certificate Manager (ACM)
resource "aws_acm_certificate" "ssl_certificate" {
  # Zertifikat muss in us_east_1 erzeugt werden (Vorschrift von AWS)
  provider                  = aws.us_east_1
  # Zertifikat soll für iubh-aws-projekt.com und www.iubh-aws-projekt.com gelten
  domain_name               = var.website_domain
  subject_alternative_names = ["*.${var.website_domain}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_certificate.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.main.zone_id
}


resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.ssl_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}