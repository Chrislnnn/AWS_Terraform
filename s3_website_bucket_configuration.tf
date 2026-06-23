# Erstellung der S3 Bucket für die statische Website
# Bucket mit dem Namen iubhbucket
resource "aws_s3_bucket" "static_website" {
  bucket = "iubhbucket"
}

# Besitzer der hochgeladenen Datein ist standardmäßig der Besitzer der Bucket
resource "aws_s3_bucket_ownership_controls" "website_bucket" {
  bucket = aws_s3_bucket.static_website.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Die Bucket soll nicht öffentlich zugreifbar sein
resource "aws_s3_bucket_public_access_block" "website_bucket" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}