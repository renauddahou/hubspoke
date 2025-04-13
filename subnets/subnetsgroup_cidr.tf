# ces group de cidr sont destiné au table de routage


output "app_api_ciam_vpn_pxy_nlb_subnet_group_cidr" {
  value = {
    "dev_api_subnet_az_a"  = aws_subnet.sn_spk_dev_api_a.cidr_block,
    "dev_api_subnet_az_b"  = aws_subnet.sn_spk_dev_api_b.cidr_block,
    "prod_api_subnet_az_a" = aws_subnet.sn_spk_prod_api_a.cidr_block,
    "prod_api_subnet_az_b" = aws_subnet.sn_spk_prod_api_b.cidr_block,
    "dev_app_subnet_az_a"  = aws_subnet.sn_spk_dev_app_a.cidr_block,
    "dev_app_subnet_az_b"  = aws_subnet.sn_spk_dev_app_b.cidr_block,
    "prod_app_subnet_az_a" = aws_subnet.sn_spk_prod_app_a.cidr_block,
    "prod_app_subnet_az_b" = aws_subnet.sn_spk_prod_app_b.cidr_block,
    "dev_nlb_subnet_az_a"  = aws_subnet.sn_spk_dev_nlb_az_a.cidr_block,
    "dev_nlb_subnet_az_b"  = aws_subnet.sn_spk_dev_nlb_az_b.cidr_block,
    "prod_nlb_subnet_az_a" = aws_subnet.sn_spk_prod_nlb_az_a.cidr_block,
    "prod_nlb_subnet_az_b" = aws_subnet.sn_spk_prod_nlb_az_b.cidr_block,
    "hub_ciam_subnet_az_a" = aws_subnet.sn_hub_private_ciam_a.cidr_block,
    "hub_ciam_subnet_az_b" = aws_subnet.sn_hub_private_ciam_b.cidr_block,
    "hub_vpn_subnet_az_a"  = aws_subnet.sn_hub_private_vpn_a.cidr_block,
    "hub_vpn_subnet_az_b"  = aws_subnet.sn_hub_private_vpn_b.cidr_block,
    "hub_pxy_subnet_az_a"  = aws_subnet.sn_hub_private_pxy_a.cidr_block,
    "hub_pxy_subnet_az_b"  = aws_subnet.sn_hub_private_pxy_b.cidr_block
  }
}


output "ciam_siem_pxy_fw_Hub_subnet_group_cidr" {
  value = {
    "hub_ciam_subnet_az_a" = aws_subnet.sn_hub_private_ciam_a.cidr_block,
    "hub_ciam_subnet_az_b" = aws_subnet.sn_hub_private_ciam_b.cidr_block,
    "hub_siem_subnet_az_a" = aws_subnet.sn_hub_private_siem_a.cidr_block,
    "hub_siem_subnet_az_b" = aws_subnet.sn_hub_private_siem_b.cidr_block,
    "hub_pxy_subnet_az_a"  = aws_subnet.sn_hub_private_pxy_a.cidr_block,
    "hub_pxy_subnet_az_b"  = aws_subnet.sn_hub_private_pxy_b.cidr_block,
    "hub_fw_subnet_az_a"   = aws_subnet.sn_hub_private_fw_a.cidr_block,
    "hub_fw_subnet_az_b"   = aws_subnet.sn_hub_private_fw_b.cidr_block
  }
}