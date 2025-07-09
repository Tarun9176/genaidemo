output "cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = module.ecs.cluster_arn
}

output "service_arn" {
  description = "ARN of the ECS service"
  value       = module.ecs.service_arn
}

output "task_definition_arn" {
  description = "ARN of the task definition"
  value       = module.ecs.task_definition_arn
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = module.ecs.load_balancer_dns
}