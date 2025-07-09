output "db_secret_arn" {
  description = "Database secret ARN"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "app_secret_arn" {
  description = "Application secret ARN"
  value       = aws_secretsmanager_secret.app_secrets.arn
}