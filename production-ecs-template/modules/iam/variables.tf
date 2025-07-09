variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "secret_arns" {
  description = "List of secret ARNs"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}