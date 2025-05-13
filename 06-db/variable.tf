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
    }
}

variable "domain_name" {
    default = "mydaws.fun"
}
variable "zone_id" {
    default = "Z00104193BYNRVYUZ1PV1"
}


# variable "zone_name" {
#     default = "mydaws.online" 
# }