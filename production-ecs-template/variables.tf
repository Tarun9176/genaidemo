# Core Configuration Variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "production-app"
}

variable "environment" {
  description = "Environment name"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

# Network Configuration
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least 2 subnets required for high availability."
  }
}

# Container Configuration - Right-sizing
variable "task_cpu" {
  description = "CPU units for tasks"
  type        = number
  default     = 512
  validation {
    condition     = contains([256, 512, 1024, 2048, 4096], var.task_cpu)
    error_message = "CPU must be 256, 512, 1024, 2048, or 4096."
  }
}

variable "task_memory" {
  description = "Memory for tasks in MB"
  type        = number
  default     = 1024
  validation {
    condition     = var.task_memory >= 512 && var.task_memory <= 30720
    error_message = "Memory must be between 512 and 30720 MB."
  }
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

# Auto Scaling Configuration
variable "desired_count" {
  description = "Desired number of tasks"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum tasks for auto scaling"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum tasks for auto scaling"
  type        = number
  default     = 20
}

# Cost Tracking Variables
variable "project_name" {
  description = "Project name for cost tracking"
  type        = string
}

variable "owner" {
  description = "Resource owner"
  type        = string
}

variable "cost_center" {
  description = "Cost center for billing"
  type        = string
}

variable "compliance_level" {
  description = "Compliance level"
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["basic", "standard", "high"], var.compliance_level)
    error_message = "Compliance level must be basic, standard, or high."
  }
}

# Sensitive Variables
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