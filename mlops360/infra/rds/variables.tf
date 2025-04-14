variable "spoke_dev_vpc_id" {
  type = string
}

variable "spoke_prod_vpc_id" {
  type = string
}

variable "db_dev_username" {
  description = "utilisateur db spk dev"
  type        = string
}

variable "db_prod_username" {
  description = "utilisateur db spk prod"
  type        = string
}

variable "nsg_vpc_spk_dev_id" {
  description = "groupe de securité spoke dev"
  type        = string
}


variable "nsg_vpc_spk_prod_id" {
  description = "groupe de securité spoke prod"
  type        = string
}


variable "spk_dev_secretsmanager_id" {
  description = "Map des secrets IDs depuis secrets_creation"
  type        = map(string)
}

variable "spk_prod_secretsmanager_id" {
  description = "Map des secrets IDs depuis secrets_creation"
  type        = map(string)
}


variable "availability_zones" {
  type = list(string)
}

variable "spoke_dev_vpc_cidr_block" {
  type = string
}

variable "spoke_prod_vpc_cidr_block" {
  type = string
}

variable "spk_dev_secrets_read_policy_arn" {
  type        = map(string)
  description = "Map des ARNs des policies dev"
}

variable "spk_prod_secrets_read_policy_arn" {
  type        = map(string)
  description = "Map des ARNs des policies prod"
}
