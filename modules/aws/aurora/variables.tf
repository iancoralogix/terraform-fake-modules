variable "namespace" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "engine_name" {
  type    = string
  default = "postgres"
}

variable "engine_version" {
  type    = string
  default = "13.6"
}
