output "cluster_arn" {
  description = "ECS cluster ARN"
  value       = aws_ecs_cluster.main.arn
}

output "service_arn" {
  description = "ECS service ARN"
  value       = aws_ecs_service.main.id
}

output "task_definition_arn" {
  description = "Task definition ARN"
  value       = aws_ecs_task_definition.main.arn
}

output "autoscaling_target_arn" {
  description = "Auto scaling target ARN"
  value       = aws_appautoscaling_target.ecs_target.arn
}