resource "aws_network_interface" "eni_private_fw_a" {
  subnet_id = var.sn_hub_private_fw_a_id
  tags = {
    INFRA = "HUB"
    Name  = "eni-private-fw-a"
  }
}


resource "aws_network_interface" "eni_private_fw_b" {
  subnet_id = var.sn_hub_private_fw_b_id
  tags = {
    INFRA = "HUB"
    Name  = "eni-private-fw-b"
  }
}
