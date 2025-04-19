module "vpc" {
    # source = "../../terraform-aws-vpc"
    source = "git::https://github.com/SAMARA-REDYY-JUNNA/terraform-aws-vpc.git?ref=main"
    project_name = var.project_name
    common_tags = var.common_tags
    public_subnet_cidr = var.public_subnet_cidrs
    private_subnet_cidr = var.private_subnet_cidrs
    database_subnet_cidr = var.database_subent_cidrs
    is_peering_required = var.is_peering_required
}