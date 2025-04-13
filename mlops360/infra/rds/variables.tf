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


variable "subnet_ids" {
  description = "Map of subnet IDs"
  type        = map(string)
}





variable "spk_dev_secretsmanager_id" {
  description = "Map des secrets IDs depuis secrets_creation"
  type        = map(string)
}

variable "spk_prod_secretsmanager_id" {
  description = "Map des secrets IDs depuis secrets_creation"
  type        = map(string)
}