variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "task_cpu" {
  description = "CPU units for tasks"
  type        = number
}

variable "task_memory" {
  description = "Memory for tasks in MB"
  type        = number
}

variable "container_image" {
  description = "Docker image URI"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
}

variable "min_capacity" {
  description = "Minimum capacity for auto scaling"
  type        = number
}

variable "max_capacity" {
  description = "Maximum capacity for auto scaling"
  type        = number
}

variable "execution_role_arn" {
  description = "ECS task execution role ARN"
  type        = string
}

variable "ecs_security_group_id" {
  description = "ECS security group ID"
  type        = string
}

variable "target_group_arn" {
  description = "Load balancer target group ARN"
  type        = string
}

variable "db_secret_arn" {
  description = "Database secret ARN"
  type        = string
}

variable "app_secret_arn" {
  description = "Application secret ARN"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}