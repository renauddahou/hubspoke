variable "hub_vpc_id" {
  type = string
}

variable "sn_hub_private_fw_a_id" {
  type = string
}

variable "use_nat_instance" {
  description = "Si vrai, utiliser une instance NAT. Sinon, utiliser une NAT Gateway"
  type        = bool
}
