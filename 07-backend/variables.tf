variable "project_name" {
    default = "expense"
  
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        project = "expense"
        environment = "dev"
        terraform = "true"
        Component = "backend"
        # appVersion = "v1.0.0"
    }
}

# variable "zone_name" {
#     default = "mydaws.online"
# }
variable "domain_name" {
    default = "mydaws.fun"
  
}
