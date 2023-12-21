
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"
  #region = var.bucket_region

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = data.aws_kms_key.shared_key.arn
      }
    }
  }
}