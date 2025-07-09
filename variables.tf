variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "my-ecs-cluster"
}

variable "environment" {
  description = "Environment name"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
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
  default     = 256
}

variable "task_memory" {
  description = "Memory for tasks in MB"
  type        = number
  default     = 512
}

variable "container_image" {
  description = "Docker image URI"
  type        = string
  default     = "nginx:latest"
}

variable "container_port" {
  description = "Container port"
  type        = number
  default     = 80
}

variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 2
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "api_key" {
  description = "API key"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Project name for cost tracking"
  type        = string
}

variable "owner" {
  description = "Resource owner for cost tracking"
  type        = string
}

variable "cost_center" {
  description = "Cost center for billing"
  type        = string
}

variable "min_capacity" {
  description = "Minimum number of tasks for autoscaling"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of tasks for autoscaling"
  type        = number
  default     = 10
}