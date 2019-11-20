resource "aws_s3_bucket" "log_bucket" {
  bucket = "sample-terraform-devops"
  acl    = "private"
}
