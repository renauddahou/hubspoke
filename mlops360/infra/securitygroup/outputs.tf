output "nsg-hub-public-alb_id" {
  value = aws_security_group.nsg_hub_public_alb.id
}


output "nsg_hub_vpn_id" {
  value = aws_security_group.nsg_hub_vpn.id
}

output "nsg_hub_public_fw_id" {
  value = aws_security_group.nsg_hub_public_fw.id
}


output "nsg_vpc_hub_id" {
  value = aws_security_group.nsg_vpc_hub.id
}


output "nsg_vpc_spk_dev_id" {
  value = aws_security_group.nsg_vpc_spk_dev.id
}


output "nsg_vpc_spk_prd_id" {
  value = aws_security_group.nsg_vpc_spk_prd.id
}