variable "namespace" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "allow_list_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "tags" {
  description = "This is any so we can pass in anything, and get it back as an output named tags"
  type        = any
  default     = {}
}
