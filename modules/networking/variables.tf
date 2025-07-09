variable "name_prefix" {
  description = "Prefix for resource names"
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

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "alb_security_group_id" {
  description = "ALB security group ID"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}