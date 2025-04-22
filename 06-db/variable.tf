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
    default = "Z09915653K8Z3UCNOLRZ5"
}


# variable "zone_name" {
#     default = "mydaws.online" 
# }