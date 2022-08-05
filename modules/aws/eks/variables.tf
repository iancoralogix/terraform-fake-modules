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
