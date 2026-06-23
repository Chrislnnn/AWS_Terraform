# Hier wird festgelegt, dass die index.html in die AWS S3 Bucket hochgeladen werden soll 
resource "aws_s3_object" "static_file" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/index.html")
}