# ECS Module Outputs
# Export important resource information for use by parent configurations

# ECS Cluster Information
# ARN of the created ECS cluster for reference by other resources
output "cluster_arn" {
  description = "ARN of the ECS cluster for cross-referencing and monitoring"
  value       = aws_ecs_cluster.main.arn
}

# ECS cluster ID for internal references
output "cluster_id" {
  description = "ID of the ECS cluster for internal resource references"
  value       = aws_ecs_cluster.main.id
}

# ECS Service Information
# ARN of the ECS service managing task deployment
output "service_arn" {
  description = "ARN of the ECS service for monitoring and management"
  value       = aws_ecs_service.main.id
}

# Service name for reference
output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.main.name
}

# Task Definition Information
# ARN of the task definition specifying container configuration
output "task_definition_arn" {
  description = "ARN of the ECS task definition for CI/CD and task management"
  value       = aws_ecs_task_definition.main.arn
}

# Load Balancer Information
# Public DNS name for accessing the deployed application
output "load_balancer_dns" {
  description = "Public DNS name of the Application Load Balancer for application access"
  value       = aws_lb.main.dns_name
}

# Load balancer ARN for advanced configurations
output "load_balancer_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.main.arn
}

# Target group ARN for additional configurations
output "target_group_arn" {
  description = "ARN of the load balancer target group"
  value       = aws_lb_target_group.main.arn
}

# Security Group Information
# Security group IDs for additional rule configurations if needed
output "alb_security_group_id" {
  description = "Security group ID for the Application Load Balancer"
  value       = aws_security_group.alb.id
}

output "ecs_security_group_id" {
  description = "Security group ID for ECS tasks"
  value       = aws_security_group.ecs_tasks.id
}

# CloudWatch Log Group
# Log group name for monitoring and debugging
output "log_group_name" {
  description = "CloudWatch log group name for ECS task logs"
  value       = aws_cloudwatch_log_group.ecs.name
}