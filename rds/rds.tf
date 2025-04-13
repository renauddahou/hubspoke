
data "aws_secretsmanager_secret_version" "spk_dev_secrets_version" {
  for_each  = var.spk_dev_secretsmanager_id
  secret_id = each.value
}


data "aws_secretsmanager_secret_version" "spk_prod_secrets_version" {
  for_each  = var.spk_prod_secretsmanager_id
  secret_id = each.value
}



resource "aws_db_instance" "db_dev" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "14.12"
  instance_class         = "db.t3.micro"
  username               = var.db_dev_username
  password               = jsondecode(data.aws_secretsmanager_secret_version.spk_dev_secrets_version["admin_password"].secret_string)
  parameter_group_name   = "default.postgres14"
  vpc_security_group_ids = [var.nsg_vpc_spk_dev_id]
  db_subnet_group_name   = aws_db_subnet_group.db_dev.name
  skip_final_snapshot    = true
  storage_encrypted      = true

  tags = {
    Environment = "DEV"
    Infra       = "SPOKE"
    Name        = "db_dev"
  }
}

resource "aws_db_subnet_group" "db_dev" {
  name = "db_dev-subnet-group"
  subnet_ids = [
    var.subnet_ids["dev_bdd_subnet_az_a"], # Sous-réseau dans la première AZ
    var.subnet_ids["dev_bdd_subnet_az_b"]  # Sous-réseau dans la deuxième AZ
  ]
}



resource "aws_db_instance" "db_prod" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "14.12"
  instance_class         = "db.t3.micro"
  username               = var.db_prod_username
  password               = jsondecode(data.aws_secretsmanager_secret_version.spk_prod_secrets_version["admin_password"].secret_string)
  parameter_group_name   = "default.postgres14"
  vpc_security_group_ids = [var.nsg_vpc_spk_prod_id]
  db_subnet_group_name   = aws_db_subnet_group.db_prod.name
  skip_final_snapshot    = true
  storage_encrypted      = true

  tags = {
    Environment = "PROD"
    Infra       = "SPOKE"
    Name        = "db_prod"
  }
}

resource "aws_db_subnet_group" "db_prod" {
  name = "db_prod-subnet-group"
  subnet_ids = [
    var.subnet_ids["prod_bdd_subnet_az_a"], # Sous-réseau dans la première AZ
    var.subnet_ids["prod_bdd_subnet_az_b"]  # Sous-réseau dans la deuxième AZ
  ]
}


