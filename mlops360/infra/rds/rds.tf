
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
    aws_subnet.sn_spk_dev_bdd_az_a.id, # Sous-réseau dans la première AZ
    aws_subnet.sn_spk_dev_bdd_az_b.id  # Sous-réseau dans la deuxième AZ
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
    aws_subnet.sn_spk_prod_bdd_az_a.id, # Sous-réseau dans la première AZ
    aws_subnet.sn_spk_prod_bdd_az_b.id  # Sous-réseau dans la deuxième AZ
  ]
}


