#############################################
# DATA SOURCE                               #
#############################################

# Récupérer les informations des instances DB existantes
data "aws_db_instance" "db_dev" {
  db_instance_identifier = var.aws_db_instance_db_dev_id
}

data "aws_db_instance" "db_prod" {
  db_instance_identifier = var.aws_db_instance_db_prod_id
}


locals {
  availability_zone_prod = try(data.aws_db_instance.db_prod.availability_zone, var.availability_zones[0])
  availability_zone_dev  = try(data.aws_db_instance.db_dev.availability_zone, var.availability_zones[0])
  # availability_zone_prod = try(var.availability_zones[0])
  # availability_zone_dev  = try(var.availability_zones[0])

  availability_zone_bprod = length(var.availability_zones) > 1 ? (
    var.availability_zones[0] == local.availability_zone_prod ?
    var.availability_zones[1] :
    var.availability_zones[0]
  ) : local.availability_zone_prod

  availability_zone_bdev = length(var.availability_zones) > 1 ? (
    var.availability_zones[0] == local.availability_zone_dev ?
    var.availability_zones[1] :
    var.availability_zones[0]
  ) : local.availability_zone_dev
}


#############################################
# SPOKE HUB                                 #
#############################################
# Subnet du natgatway pour permettre au ressource de sortir sur internet pour des mise à jour etc..
resource "aws_subnet" "sn_hub_public_ngw_a" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-public-ngw-a"
  }
  availability_zone_id                = local.availability_zone_prod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 0)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}



# Subnet du firwal pour la partie wan
resource "aws_subnet" "sn_hub_public_alb_fw_a" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-public-alb-fw-a"
  }
  availability_zone_id                = local.availability_zone_prod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 1)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}

# subnet du firwal pour la partie lan
resource "aws_subnet" "sn_hub_private_fw_a" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-private-fw-a"
  }
  availability_zone_id                = local.availability_zone_prod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 2)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}



#Subnet des ressource custom IAM Ex: keycloack
resource "aws_subnet" "sn_hub_private_ciam_a" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-private-ciam-a"
  }
  availability_zone_id                = local.availability_zone_prod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 3)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}



resource "aws_subnet" "sn_hub_public_ngw_b" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-public-ngw-b"
  }
  availability_zone_id                = local.availability_zone_bprod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 4)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}


resource "aws_subnet" "sn_hub_public_alb_fw_b" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-public-alb-fw-b"
  }
  availability_zone_id                = local.availability_zone_bprod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 5)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}




resource "aws_subnet" "sn_hub_private_fw_b" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-private-fw-b"
  }
  availability_zone_id                = local.availability_zone_bprod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 6)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}


resource "aws_subnet" "sn_hub_private_ciam_b" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-private-ciam-b"
  }
  availability_zone_id                = local.availability_zone_bprod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 7)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}


# Subnet du vpn Ex: openvpn
resource "aws_subnet" "sn_hub_private_vpn_a" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-private-vpn-a"
  }
  availability_zone_id                = local.availability_zone_prod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 8)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}


# Subnet du proxy serveur greffer au Natgatway les ressource passerons par lui pour allez sur internet
resource "aws_subnet" "sn_hub_private_pxy_a" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-private-pxy-a"
  }
  availability_zone_id                = local.availability_zone_prod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 9)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}

# Subnets des outils SIEM et HIDS 
resource "aws_subnet" "sn_hub_private_siem_a" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-private-siem-a"
  }
  availability_zone_id                = local.availability_zone_prod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 10)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}



resource "aws_subnet" "sn_hub_private_vpn_b" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-private-vpn-b"
  }
  availability_zone_id                = local.availability_zone_bprod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 11)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}



resource "aws_subnet" "sn_hub_private_pxy_b" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-private-pxy-b"
  }
  availability_zone_id                = local.availability_zone_bprod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 12)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}


resource "aws_subnet" "sn_hub_private_siem_b" {
  tags = {
    Environment = "TRANSIT"
    Infra       = "HUB"
    Name        = "sn-hub-private-siem-b"
  }
  availability_zone_id                = local.availability_zone_bprod
  cidr_block                          = cidrsubnet(var.hub_vpc_cidr_block, 4, 13)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.hub_vpc_id
}


#############################################
# SPOKE DEV                                 #
#############################################

# Subnets de base de donnée
resource "aws_subnet" "sn_spk_dev_bdd_az_a" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-bdd-az-a"
  }
  availability_zone_id                = var.availability_zones[0]
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 1)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}




resource "aws_subnet" "sn_spk_dev_bdd_az_b" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-bdd-az-b"
  }
  availability_zone_id                = var.availability_zones[1]
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 2)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}



# Subnet de networkork load balancer
resource "aws_subnet" "sn_spk_dev_nlb_az_a" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-nlb-az-a"
  }
  availability_zone_id                = var.availability_zones[0]
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 3)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}




resource "aws_subnet" "sn_spk_dev_nlb_az_b" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-nlb-az-b"
  }
  availability_zone_id                = var.availability_zones[1]
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 4)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}




# subnet des apis
resource "aws_subnet" "sn_spk_dev_api_a" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-api-a"
  }
  availability_zone_id                = local.availability_zone_dev
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 5)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}


# subnet des applications
resource "aws_subnet" "sn_spk_dev_app_a" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-app-a"
  }
  availability_zone_id                = local.availability_zone_dev
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 6)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}


# Subnet des outils marchine learning et Datascience
resource "aws_subnet" "sn_spk_dev_mldata_a" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-mldata-a"
  }
  availability_zone_id                = local.availability_zone_dev
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 7)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}

# Subnets des outils devops
resource "aws_subnet" "sn_spk_dev_devops_a" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-devops-a"
  }
  availability_zone_id                = local.availability_zone_dev
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 8)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}



resource "aws_subnet" "sn_spk_dev_api_b" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-api-b"
  }
  availability_zone_id                = local.availability_zone_bdev
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 9)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}



resource "aws_subnet" "sn_spk_dev_app_b" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-app-b"
  }
  availability_zone_id                = local.availability_zone_bdev
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 10)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}


resource "aws_subnet" "sn_spk_dev_mldata_b" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-mldata-b"
  }
  availability_zone_id                = local.availability_zone_bdev
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 11)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}


resource "aws_subnet" "sn_spk_dev_devops_b" {
  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "sn-spk-dev-devops-b"
  }
  availability_zone_id                = local.availability_zone_bdev
  cidr_block                          = cidrsubnet(var.spoke_dev_vpc_cidr_block, 4, 12)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_dev_vpc_id
}


#############################################
# SPOKE PROD                                #
#############################################


resource "aws_subnet" "sn_spk_prod_bdd_az_a" {
  tags = {
    Environment = "PROD"
    Infra       = "SPOKE"
    Name        = "sn-spk-prod-bdd-az-a"
  }
  availability_zone_id                = var.availability_zones[0]
  cidr_block                          = cidrsubnet(var.spoke_prod_vpc_cidr_block, 4, 1)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_prod_vpc_id
}



resource "aws_subnet" "sn_spk_prod_bdd_az_b" {
  tags = {
    Environment = "PROD"
    Infra       = "SPOKE"
    Name        = "sn-spk-prod-bdd-az-b"
  }
  availability_zone_id                = var.availability_zones[1]
  cidr_block                          = cidrsubnet(var.spoke_prod_vpc_cidr_block, 4, 2)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_prod_vpc_id
}




resource "aws_subnet" "sn_spk_prod_nlb_az_a" {
  tags = {
    Environment = "PROD"
    Infra       = "SPOKE"
    Name        = "sn-spk-prod-nlb-az-a"
  }
  availability_zone_id                = var.availability_zones[0]
  cidr_block                          = cidrsubnet(var.spoke_prod_vpc_cidr_block, 4, 3)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_prod_vpc_id
}




resource "aws_subnet" "sn_spk_prod_nlb_az_b" {
  tags = {
    Environment = "PROD"
    Infra       = "SPOKE"
    Name        = "sn-spk-prod-nlb-az-b"
  }
  availability_zone_id                = var.availability_zones[1]
  cidr_block                          = cidrsubnet(var.spoke_prod_vpc_cidr_block, 4, 4)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_prod_vpc_id
}



resource "aws_subnet" "sn_spk_prod_api_a" {
  tags = {
    Environment = "PROD"
    Infra       = "SPOKE"
    Name        = "sn-spk-prod-api-a"
  }
  availability_zone_id                = local.availability_zone_prod
  cidr_block                          = cidrsubnet(var.spoke_prod_vpc_cidr_block, 4, 5)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_prod_vpc_id
}



resource "aws_subnet" "sn_spk_prod_app_a" {
  tags = {
    Environment = "PROD"
    Infra       = "SPOKE"
    Name        = "sn-spk-prod-app-a"
  }
  availability_zone_id                = local.availability_zone_prod
  cidr_block                          = cidrsubnet(var.spoke_prod_vpc_cidr_block, 4, 6)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_prod_vpc_id
}


resource "aws_subnet" "sn_spk_prod_mldata_a" {
  tags = {
    Environment = "PROD"
    Infra       = "SPOKE"
    Name        = "sn-spk-prod-mldata-a"
  }
  availability_zone_id                = local.availability_zone_prod
  cidr_block                          = cidrsubnet(var.spoke_prod_vpc_cidr_block, 4, 7)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_prod_vpc_id
}




resource "aws_subnet" "sn_spk_prod_api_b" {
  tags = {
    Environment = "PROD"
    Infra       = "SPOKE"
    Name        = "sn-spk-prod-api-b"
  }
  availability_zone_id                = local.availability_zone_bprod
  cidr_block                          = cidrsubnet(var.spoke_prod_vpc_cidr_block, 4, 8)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_prod_vpc_id
}



resource "aws_subnet" "sn_spk_prod_app_b" {
  tags = {
    Environment = "PROD"
    Infra       = "SPOKE"
    Name        = "sn-spk-prod-app-b"
  }
  availability_zone_id                = local.availability_zone_bprod
  cidr_block                          = cidrsubnet(var.spoke_prod_vpc_cidr_block, 4, 9)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_prod_vpc_id
}


resource "aws_subnet" "sn_spk_prod_mldata_b" {
  tags = {
    Environment = "PROD"
    Infra       = "SPOKE"
    Name        = "sn-spk-prod-mldata-b"
  }
  availability_zone_id                = local.availability_zone_bprod
  cidr_block                          = cidrsubnet(var.spoke_prod_vpc_cidr_block, 4, 10)
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = var.spoke_prod_vpc_id
}
