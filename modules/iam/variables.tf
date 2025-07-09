variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

variable "secret_arns" {
  description = "List of secret ARNs to grant access to"
  type        = list(string)
  default     = []
}