####################################################
# *** VPC VARIABLES CIDR***                        #
####################################################
variable "region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "vpc_hub_cidr" {
  type = string
}

variable "vpc_spoke_dev_cidr" {
  type = string
}

variable "vpc_spoke_prod_cidr" {
  type = string
}

####################################################
# *** RDS VARIABLES***                             #
####################################################

variable "db_dev_username" {
  description = "utilisateur db spk dev"
  type        = string
}

variable "db_prod_username" {
  description = "utilisateur db spk prod"
  type        = string
}



####################################################
# *** SECRETS MANAGER***                             #
####################################################

variable "dev_secrets" {
  description = "A map of secrets to create in AWS Secrets Manager"
  type = map(object({
    name          = string
    description   = string
    secret_string = string
  }))
}

variable "prod_secrets" {
  description = "A map of secrets to create in AWS Secrets Manager"
  type = map(object({
    name          = string
    description   = string
    secret_string = string
  }))
}
