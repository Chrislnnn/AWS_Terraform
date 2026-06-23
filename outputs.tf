# Definire Ausgaben, die zurückgegeben werden, nachdem Terraform Apply ausgeführt wurde

# Cloudfront ID
output "cloudfront_distribution_id" {
  description = "ID der CloudFront-Distribution"
  value       = aws_cloudfront_distribution.s3_distribution.id
}

# Cloudfront URL
output "cloudfront_distribution_url" {
  description = "HTTPS-URL der CloudFront-Distribution"
  value       = "https://${aws_cloudfront_distribution.s3_distribution.domain_name}"
}

# URL der Website
output "website_url" {
  description = "Oeffentliche HTTPS-URL der Website"
  value       = "https://${var.website_domain}"
}