variable "namespace" {
  type    = string
  default = "grunty"
}

variable "environment" {
  type    = string
  default = "development"
}

variable "subnet_count" {
  type    = number
  default = 4

  validation {
    condition     = var.subnet_count > 0 && var.subnet_count < 17
    error_message = "Max 16 subnets, minimum 1 subnet."
  }
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "tags" {
  description = "This is any so we can pass in anything, and get it back as an output named tags"
  type        = any
  default     = {}
}
