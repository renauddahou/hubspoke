# Création de vpc hub
resource "aws_vpc" "hub_transit" {
  cidr_block           = var.vpc_hub_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    INFRA = "HUB"
    Name  = "${var.project_name}-HUB-TRANSIT"
  }
}



# Création de vpc spoke_dev
resource "aws_vpc" "spoke_dev" {
  cidr_block           = var.vpc_spoke_dev_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    INFRA = "SPOKE-DEV"
    Name  = "${var.project_name}-SPOKE-DEV"
  }
}



# Création de vpc spoke_prod
resource "aws_vpc" "spoke_prod" {
  cidr_block           = var.vpc_spoke_prod_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    INFRA = "SPOKE-PROD"
    Name  = "${var.project_name}-SPOKE-PROD"
  }
}

