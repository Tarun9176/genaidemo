variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}