variable "region" {
  description = "AWS Region to Bootstrap"
  type = string
  default = "eu-central-1"
}

variable "project_name" {
  description = "Project name"
  type = string
  default = "postgres-diy"
}

variable "env" {
  description = "Environment name"
  type = string
  default = "test"
}

variable "tags" {
  description = "Project tags"
  type = map(any)
}