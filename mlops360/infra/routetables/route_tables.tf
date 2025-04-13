# Création de la tables de routage privée du Hub
resource "aws_route_table" "hub_transit_private" {
  vpc_id = var.hub_vpc_id
  tags = {
    Name = "rtb-hub-private"
  }
}


# Récupération des tables de routage

data "aws_route_table" "hub_transit_default" {
  filter {
    name   = "vpc-id"
    values = [var.hub_vpc_id]
  }

  filter {
    name   = "association.main"
    values = ["true"]
  }
}

# pour tagguer ces route recupérée via data qui n'avaient pas de tag initialement
resource "aws_ec2_tag" "tag_hub_transit_default_route_table" {
  resource_id = data.aws_route_table.hub_transit_default.id

  key   = "Name"
  value = "rtb-hub-public"
}



data "aws_route_table" "spoke_dev_default" {
  filter {
    name   = "vpc-id"
    values = [var.spoke_dev_vpc_id]
  }

  filter {
    name   = "association.main"
    values = ["true"]
  }
}

# pour tagguer ces route recupérée via data qui n'avaient pas de tag initialement
resource "aws_ec2_tag" "tag_spoke_dev_default_route_table" {
  resource_id = data.aws_route_table.spoke_dev_default.id

  key   = "Name"
  value = "rtb-spoke-dev-private"
}



data "aws_route_table" "spoke_prod_default" {
  filter {
    name   = "vpc-id"
    values = [var.spoke_prod_vpc_id]
  }

  filter {
    name   = "association.main"
    values = ["true"]
  }
}

# pour tagguer ces route recupérée via data qui n'avaient pas de tag initialement
resource "aws_ec2_tag" "tag_spoke_prod_default_route_table" {
  resource_id = data.aws_route_table.spoke_prod_default.id

  key   = "Name"
  value = "rtb-spoke-prod-private"
}




# Route public vers internet en passant par internete gateways 
resource "aws_route" "public_hub_to_igw" {
  route_table_id         = data.aws_route_table.hub_transit_default.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway_hub_transit_id
}


# Route public vers les sous reseau spoke applicatif en passant par l'INterface Network privée du Firwall
resource "aws_route" "public_hub_to_private_eni_fw" {
  for_each = {
    for idx, key in keys(var.app_api_ciam_vpn_pxy_nlb_subnet_group_cidr) :
    "${key}-${idx % length(var.eni_private_fw_ids)}" => {
      eni  = var.eni_private_fw_ids[idx % length(var.eni_private_fw_ids)]
      cidr = var.app_api_ciam_vpn_pxy_nlb_subnet_group_cidr[key]
    }
  }

  route_table_id         = data.aws_route_table.hub_transit_default.id
  destination_cidr_block = each.value.cidr
  network_interface_id   = each.value.eni
}


# Route privé vers les sous reseaux spoke dev  en passant par le peering
resource "aws_route" "private_hub_to_spoke_dev" {
  route_table_id            = aws_route_table.hub_transit_private.id
  destination_cidr_block    = var.spoke_dev_vpc_cidr_block
  vpc_peering_connection_id = var.pcx_hub2spk_dev_id
}

# Route privé vers les sous reseaux spoke prod  en passant par le peering
resource "aws_route" "private_hub_to_spoke_prod" {
  route_table_id            = aws_route_table.hub_transit_private.id
  destination_cidr_block    = var.spoke_prod_vpc_cidr_block
  vpc_peering_connection_id = var.pcx_hub2spk_prod_id
}



# Route privé vers les sous reseaux Hub  en passant par le peering
resource "aws_route" "spoke_prod_to_private_hub" {
  for_each                  = var.ciam_siem_pxy_fw_Hub_subnet_group_cidr
  route_table_id            = data.aws_route_table.spoke_prod_default.id
  destination_cidr_block    = each.value
  vpc_peering_connection_id = var.pcx_hub2spk_prod_id
}


# Route privé vers les sous reseaux Hub  en passant par le peering
resource "aws_route" "spoke_dev_to_private_hub" {
  for_each                  = var.ciam_siem_pxy_fw_Hub_subnet_group_cidr
  route_table_id            = data.aws_route_table.spoke_dev_default.id
  destination_cidr_block    = each.value
  vpc_peering_connection_id = var.pcx_hub2spk_dev_id
}





#on ne peut pas avoir deux routes différentes vers une même destination dans une table de routage. Il faut choisir soit l’instance NAT soit la NAT Gateway.

# # Route privé vers internet en passant par nat

resource "aws_route" "private_hub_to_nat" {
  route_table_id         = aws_route_table.hub_transit_private.id
  destination_cidr_block = "0.0.0.0/0"

  # Conditionnels pour choisir le bon type de route
  network_interface_id = var.use_nat_instance ? var.nat_instance_eni_id : null
  nat_gateway_id       = var.use_nat_instance ? null : var.nat_gateway_internal_hub_id

  timeouts {
    create = "2m"
    delete = "2m"
  }
}




# association des tables de routage au subnets

resource "aws_route_table_association" "hub_transit_default_fw" {
  for_each       = var.sn_pub_fw_group_id
  subnet_id      = each.value
  route_table_id = data.aws_route_table.hub_transit_default.id
}



resource "aws_route_table_association" "hub_transit_private_vpn" {
  for_each       = var.sn_priv_vpn_group_id
  subnet_id      = each.value
  route_table_id = aws_route_table.hub_transit_private.id
}


resource "aws_route_table_association" "hub_transit_private_pxy" {
  for_each       = var.sn_priv_pxy_group_id
  subnet_id      = each.value
  route_table_id = aws_route_table.hub_transit_private.id
}



resource "aws_route_table_association" "spoke_dev_default_dev" {
  for_each       = var.sn_spk_dev_group_id
  subnet_id      = each.value
  route_table_id = data.aws_route_table.spoke_dev_default.id
}


resource "aws_route_table_association" "spoke_prod_default_prod" {
  for_each       = var.sn_spk_prod_group_id
  subnet_id      = each.value
  route_table_id = data.aws_route_table.spoke_prod_default.id
}