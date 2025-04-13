output "bdd_subnet_group_id" {
  value = {
    "dev_bdd_subnet_az_a"  = aws_subnet.sn_spk_dev_bdd_az_a.id,
    "dev_bdd_subnet_az_b"  = aws_subnet.sn_spk_dev_bdd_az_b.id,
    "prod_bdd_subnet_az_a" = aws_subnet.sn_spk_prod_bdd_az_a.id,
    "prod_bdd_subnet_az_b" = aws_subnet.sn_spk_prod_bdd_az_b.id
  }
}



# group de subnet à associer au table de routage


output "sn_pub_fw_group_id" {
  value = {
    "sn_hub_public_alb_fw_a" = aws_subnet.sn_hub_public_alb_fw_a.id,
    "sn_hub_public_alb_fw_b" = aws_subnet.sn_hub_public_alb_fw_b.id
  }
}



output "sn_priv_vpn_group_id" {
  value = {
    "hub_vpn_subnet_az_a" = aws_subnet.sn_hub_private_vpn_a.id,
    "hub_vpn_subnet_az_b" = aws_subnet.sn_hub_private_vpn_b.id
  }
}


output "sn_priv_pxy_group_id" {
  value = {
    "sn_hub_private_pxy_a" = aws_subnet.sn_hub_private_pxy_a.id,
    "sn_hub_private_pxy_b" = aws_subnet.sn_hub_private_pxy_b.id
  }
}





output "sn_spk_dev_group_id" {
  value = {
    "sn_spk_dev_bdd_az_a" = aws_subnet.sn_spk_dev_bdd_az_a.id,
    "sn_spk_dev_bdd_az_b" = aws_subnet.sn_spk_dev_bdd_az_b.id
    "sn_spk_dev_nlb_az_a" = aws_subnet.sn_spk_dev_nlb_az_a.id
    "sn_spk_dev_nlb_az_b" = aws_subnet.sn_spk_dev_nlb_az_b.id
    "sn_spk_dev_api_a"    = aws_subnet.sn_spk_dev_api_a.id
    "sn_spk_dev_app_a"    = aws_subnet.sn_spk_dev_app_a.id
    "sn_spk_dev_mldata_a" = aws_subnet.sn_spk_dev_mldata_a.id
    "sn_spk_dev_devops_a" = aws_subnet.sn_spk_dev_devops_a.id
    "sn_spk_dev_api_b"    = aws_subnet.sn_spk_dev_api_b.id
    "sn_spk_dev_app_b"    = aws_subnet.sn_spk_dev_app_b.id
    "sn_spk_dev_mldata_b" = aws_subnet.sn_spk_dev_mldata_b.id
    "sn_spk_dev_devops_b" = aws_subnet.sn_spk_dev_devops_b.id

  }
}


output "sn_spk_prod_group_id" {
  value = {
    "sn_spk_prod_bdd_az_a" = aws_subnet.sn_spk_prod_bdd_az_a.id,
    "sn_spk_prod_bdd_az_b" = aws_subnet.sn_spk_prod_bdd_az_b.id
    "sn_spk_prod_nlb_az_a" = aws_subnet.sn_spk_prod_nlb_az_a.id
    "sn_spk_prod_nlb_az_b" = aws_subnet.sn_spk_prod_nlb_az_b.id
    "sn_spk_prod_api_a"    = aws_subnet.sn_spk_prod_api_a.id
    "sn_spk_prod_app_a"    = aws_subnet.sn_spk_prod_app_a.id
    "sn_spk_prod_mldata_a" = aws_subnet.sn_spk_prod_mldata_a.id
    "sn_spk_prod_api_b"    = aws_subnet.sn_spk_prod_api_b.id
    "sn_spk_prod_app_b"    = aws_subnet.sn_spk_prod_app_b.id
    "sn_spk_prod_mldata_b" = aws_subnet.sn_spk_prod_mldata_b.id
  }
}