variable "hub_vpc_id" {
  type = string
}

variable "spoke_dev_vpc_id" {
  type = string
}

variable "spoke_prod_vpc_id" {
  type = string
}



variable "hub_vpc_cidr_block" {
  type = string
}

variable "spoke_dev_vpc_cidr_block" {
  type = string
}

variable "spoke_prod_vpc_cidr_block" {
  type = string
}


variable "aws_db_instance_db_dev_id" {
  type = string
}

variable "aws_db_instance_db_prod_id" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}