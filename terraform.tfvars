####################################################
# *** VPC VARIABLES CIDR***                        #
####################################################
region = "us-east-1"

project_name = "mlops360"

vpc_hub_cidr = "172.16.0.0/20"

vpc_spoke_dev_cidr = "172.17.0.0/16"

vpc_spoke_prod_cidr = "172.18.0.0/16"


####################################################
# *** RDS VARIABLES***                             #
####################################################

db_dev_username = "admindevuser"

db_prod_username = "adminproduser"


####################################################
# *** SECRETS MANAGERS VARIABLES***                             #
####################################################

dev_secrets = {
  admin_password = {
    name          = "admin-database-password"
    description   = "Mot de passe de la base de données principale"
    secret_string = "SuperSecret123!"
  }
}


prod_secrets = {
  admin_password = {
    name          = "admin-database-password"
    description   = "Mot de passe de la base de données principale"
    secret_string = "SuperSecret123!"
  }
}

