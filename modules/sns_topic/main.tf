# The central S3 bucket instance
resource "aws_s3_bucket" "app_storage" {
  bucket        = var.bucket_name
  force_destroy = false # Protects objects from accidental pipeline purges

  tags = {
    Name = "app-file-storage"
  }
}

# Enforce explicit Object Versioning for easy rollbacks
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.app_storage.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Force Default Server-Side Encryption (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.app_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Strict Public Access Block (Anti-Data-Leak Safeguard)
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.app_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}