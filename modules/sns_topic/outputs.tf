output "bucket_name" {
  value       = aws_s3_bucket.app_storage.id
  description = "The verified bucket identification handle."
}

output "bucket_arn" {
  value       = aws_s3_bucket.app_storage.arn
  description = "The complete Amazon Resource Name for targeted IAM scoping."
}