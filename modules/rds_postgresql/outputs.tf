output "endpoint" {
  description = "The connection endpoint address string for your database service cluster"
  value       = aws_db_instance.postgres.endpoint
}

output "db_name" {
  value = aws_db_instance.postgres.db_name
}