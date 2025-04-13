resource "aws_internet_gateway" "igw_hub_transit" {
  tags = {
    Infra = "HUB"
    Name  = "igw-hub-transit"
  }

  vpc_id = var.hub_vpc_id
}