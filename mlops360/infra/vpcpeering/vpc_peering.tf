resource "aws_vpc_peering_connection" "pcx_hub2spk_dev" {
  peer_vpc_id = var.spoke_dev_vpc_id
  vpc_id      = var.hub_vpc_id
  auto_accept = true
  tags = {
    INFRA = "VPC PERING"
    Name  = "pcx-hub2spk-dev"
  }
}

resource "aws_vpc_peering_connection" "pcx_hub2spk_prod" {
  peer_vpc_id = var.spoke_prod_vpc_id
  vpc_id      = var.hub_vpc_id
  auto_accept = true
  tags = {
    INFRA = "VPC PERING"
    Name  = "pcx-hub2spk-prod"
  }
}

