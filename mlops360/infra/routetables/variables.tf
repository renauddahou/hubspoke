variable "hub_vpc_id" {
  type = string
}

variable "spoke_dev_vpc_id" {
  type = string
}

variable "spoke_prod_vpc_id" {
  type = string
}


variable "spoke_dev_vpc_cidr_block" {
  type = string
}

variable "spoke_prod_vpc_cidr_block" {
  type = string
}


variable "eni_private_fw_ids" {
  type = list(string)
}

variable "app_api_ciam_vpn_pxy_nlb_subnet_group_cidr" {
  description = "Map of subnet CIDR"
  type        = map(string)
}


variable "pcx_hub2spk_dev_id" {
  type = string
}


variable "pcx_hub2spk_prod_id" {
  type = string
}


variable "ciam_siem_pxy_fw_Hub_subnet_group_cidr" {
  description = "Map of subnet CIDR"
  type        = map(string)
}

variable "use_nat_instance" {
  description = "Si vrai, utiliser une instance NAT. Sinon, utiliser une NAT Gateway"
  type        = bool
  default     = true
}


variable "internet_gateway_hub_transit_id" {
  description = "ID de l'Internet Gateway du VPC hub"
  type        = string
}


variable "nat_gateway_internal_hub_id" {
  description = "ID du NAT Gateway privé dans le VPC hub"
  type        = string
}




variable "nat_instance_eni_id" {
  type = string
}



variable "sn_pub_fw_group_id" {
  type = map(string)
}



variable "sn_priv_vpn_group_id" {
  type = map(string)
}


variable "sn_priv_pxy_group_id" {
  type = map(string)
}

variable "sn_spk_dev_group_id" {
  type = map(string)
}

variable "sn_spk_prod_group_id" {
  type = map(string)
}