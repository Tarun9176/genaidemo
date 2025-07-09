output "db_secret_arn" {
  description = "ARN of database credentials secret"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "app_secret_arn" {
  description = "ARN of application secrets"
  value       = aws_secretsmanager_secret.app_secrets.arn
}