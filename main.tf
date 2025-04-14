data "aws_availability_zones" "available_zones" {}

module "vpc" {
  source              = "./mlops360/infra/vpc"
  project_name        = var.project_name
  vpc_hub_cidr        = var.vpc_hub_cidr
  vpc_spoke_dev_cidr  = var.vpc_spoke_dev_cidr
  vpc_spoke_prod_cidr = var.vpc_spoke_prod_cidr
}

module "rds" {
  source                     = "./mlops360/infra/rds"
  spoke_dev_vpc_id          = module.vpc.spoke_dev_vpc_id
  spoke_prod_vpc_id         = module.vpc.spoke_prod_vpc_id
  spoke_dev_vpc_cidr_block  = module.vpc.spoke_dev_vpc_cidr_block
  spoke_prod_vpc_cidr_block = module.vpc.spoke_prod_vpc_cidr_block
  nsg_vpc_spk_dev_id         = module.securitygroup.nsg_vpc_spk_dev_id
  nsg_vpc_spk_prod_id        = module.securitygroup.nsg_vpc_spk_prd_id
  db_dev_username            = var.db_dev_username
  db_prod_username           = var.db_prod_username
  spk_dev_secretsmanager_id  = module.secretsmanager.spk_dev_secretsmanager_id
  spk_prod_secretsmanager_id = module.secretsmanager.spk_prod_secretsmanager_id
  spk_dev_secrets_read_policy_arn =  module.secretsmanager.spk_dev_secrets_read_policy_arn
  spk_prod_secrets_read_policy_arn = module.secretsmanager.spk_prod_secrets_read_policy_arn
  availability_zones         = data.aws_availability_zones.available_zones.zone_ids

}


module "subnets" {
  source                    = "./mlops360/infra/subnets"
  hub_vpc_id                = module.vpc.hub_vpc_id
  spoke_dev_vpc_id          = module.vpc.spoke_dev_vpc_id
  spoke_prod_vpc_id         = module.vpc.spoke_prod_vpc_id
  hub_vpc_cidr_block        = module.vpc.hub_vpc_cidr_block
  spoke_dev_vpc_cidr_block  = module.vpc.spoke_dev_vpc_cidr_block
  spoke_prod_vpc_cidr_block = module.vpc.spoke_prod_vpc_cidr_block
  aws_db_instance_db_dev_id=module.rds.aws_db_instance_db_dev_id
  aws_db_instance_db_prod_id=module.rds.aws_db_instance_db_prod_id
  availability_zones         = data.aws_availability_zones.available_zones.zone_ids


}

module "securitygroup" {
  source             = "./mlops360/infra/securitygroup"
  hub_vpc_id         = module.vpc.hub_vpc_id
  spoke_dev_vpc_id   = module.vpc.spoke_dev_vpc_id
  spoke_prod_vpc_id  = module.vpc.spoke_prod_vpc_id
  hub_vpc_cidr_block = module.vpc.hub_vpc_cidr_block
}


module "lambda_secretrotation" {
  source = "./mlops360/infra/lambda/secretrotation"
}


module "secretsmanager" {
  source                     = "./mlops360/infra/secretsmanager"
  lambda_secret_rotation_arn = module.lambda_secretrotation.lambda_secret_rotation_arn
  dev_secrets                = var.dev_secrets
  prod_secrets               = var.prod_secrets
}





module "int_nat_gateways" {
  source                 = "./mlops360/infra/int_nat_gateways"
  hub_vpc_id             = module.vpc.hub_vpc_id
  sn_hub_private_fw_a_id = module.subnets.sn_hub_private_fw_a_id
  use_nat_instance       = true
}


module "int_nat_instance" {
  source                 = "./mlops360/infra/int_nat_instance"
  hub_vpc_id             = module.vpc.hub_vpc_id
  sn_hub_private_fw_a_id = module.subnets.sn_hub_private_fw_a_id
  nsg_vpc_hub_id         = module.securitygroup.nsg_vpc_hub_id
}

module "private_eni_fw" {
  source                 = "./mlops360/infra/private_eni_fw"
  sn_hub_private_fw_a_id = module.subnets.sn_hub_private_fw_a_id
  sn_hub_private_fw_b_id = module.subnets.sn_hub_private_fw_b_id
}


module "vpcpeering" {
  source            = "./mlops360/infra/vpcpeering"
  hub_vpc_id        = module.vpc.hub_vpc_id
  spoke_dev_vpc_id  = module.vpc.spoke_dev_vpc_id
  spoke_prod_vpc_id = module.vpc.spoke_prod_vpc_id
}



module "routetables" {
  source                    = "./mlops360/infra/routetables"
  hub_vpc_id                = module.vpc.hub_vpc_id
  spoke_dev_vpc_id          = module.vpc.spoke_dev_vpc_id
  spoke_prod_vpc_id         = module.vpc.spoke_prod_vpc_id
  spoke_dev_vpc_cidr_block  = module.vpc.spoke_dev_vpc_cidr_block
  spoke_prod_vpc_cidr_block = module.vpc.spoke_prod_vpc_cidr_block

  pcx_hub2spk_dev_id  = module.vpcpeering.pcx_hub2spk_dev_id
  pcx_hub2spk_prod_id = module.vpcpeering.pcx_hub2spk_prod_id

  app_api_ciam_vpn_pxy_nlb_subnet_group_cidr = module.subnets.app_api_ciam_vpn_pxy_nlb_subnet_group_cidr
  ciam_siem_pxy_fw_Hub_subnet_group_cidr     = module.subnets.ciam_siem_pxy_fw_Hub_subnet_group_cidr
  sn_pub_fw_group_id                         = module.subnets.sn_pub_fw_group_id
  sn_priv_vpn_group_id                       = module.subnets.sn_priv_vpn_group_id
  sn_priv_pxy_group_id                       = module.subnets.sn_priv_pxy_group_id
  sn_spk_dev_group_id                        = module.subnets.sn_spk_dev_group_id
  sn_spk_prod_group_id                       = module.subnets.sn_spk_prod_group_id
  eni_private_fw_ids                         = module.private_eni_fw.eni_private_fw_ids

  internet_gateway_hub_transit_id = module.int_nat_gateways.internet_gateway_hub_transit_id
  nat_gateway_internal_hub_id     = module.int_nat_gateways.nat_gateway_internal_hub_id
  nat_instance_eni_id             = module.int_nat_instance.nat_instance_eni_id
  use_nat_instance                = true
}