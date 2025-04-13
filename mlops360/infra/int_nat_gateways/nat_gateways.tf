# NAT Gateway (créé SEULEMENT quand use_nat_instance = false)
resource "aws_nat_gateway" "intnernal_nat_hub" {
  count = var.use_nat_instance ? 0 : 1
  tags = {
    Infra = "HUB"
    Name  = "intnernal-nat-hub"
  }


  connectivity_type = "private"
  subnet_id         = var.sn_hub_private_fw_a_id
}


