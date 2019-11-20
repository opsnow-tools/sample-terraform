resource "aws_s3_bucket" "log_bucket" {
  bucket = "sample-terraform-dev"
  acl    = "private"
}
