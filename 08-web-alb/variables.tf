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
    Component = "web-alb"
  }
}

variable "domain_name" {
  default = "mydaws.fun"
} 

variable "zone_id" {
  default = "Z09915653K8Z3UCNOLRZ5"
  
}