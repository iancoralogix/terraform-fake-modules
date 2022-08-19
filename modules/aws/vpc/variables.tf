variable "namespace" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
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
