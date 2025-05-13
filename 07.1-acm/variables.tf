variable "project_name" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project = "expense"
    Environment = "dev"
    Terraform = "true"
    Component = "app-alb"
  }
}

variable "domain_name" {
  default = "mydaws.fun"
}

variable "zone_id" {
  default = "Z00104193BYNRVYUZ1PV1"
}