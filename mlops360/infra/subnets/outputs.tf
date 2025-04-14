output "sn_hub_public_ngw_a_id" {
  value = aws_subnet.sn_hub_public_ngw_a.id
}


output "sn_hub_public_alb_fw_a_id" {
  value = aws_subnet.sn_hub_public_alb_fw_a.id
}


output "sn_hub_private_fw_a_id" {
  value = aws_subnet.sn_hub_private_fw_a.id
}


output "sn_hub_private_ciam_a_id" {
  value = aws_subnet.sn_hub_private_ciam_a.id
}


output "sn_hub_public_ngw_b_id" {
  value = aws_subnet.sn_hub_public_ngw_b.id
}

output "sn_hub_public_alb_fw_b_id" {
  value = aws_subnet.sn_hub_public_alb_fw_b.id
}


output "sn_hub_private_fw_b_id" {
  value = aws_subnet.sn_hub_private_fw_b.id
}


output "sn_hub_private_ciam_b_id" {
  value = aws_subnet.sn_hub_private_ciam_b.id
}

output "sn_hub_private_vpn_a_id" {
  value = aws_subnet.sn_hub_private_vpn_a.id
}


output "sn_hub_private_pxy_a_id" {
  value = aws_subnet.sn_hub_private_pxy_a.id
}



output "sn_hub_private_siem_a_id" {
  value = aws_subnet.sn_hub_private_siem_a.id
}


output "sn_hub_private_vpn_b_id" {
  value = aws_subnet.sn_hub_private_vpn_b.id
}



output "sn_hub_private_pxy_b_id" {
  value = aws_subnet.sn_hub_private_pxy_b.id
}


output "sn_hub_private_siem_b_id" {
  value = aws_subnet.sn_hub_private_siem_b.id
}

output "sn_spk_dev_bdd_az_a_id" {
  value = tolist(data.aws_db_subnet_group.db_dev.subnet_ids)[0]
}

output "sn_spk_dev_bdd_az_b_id" {
  value = tolist(data.aws_db_subnet_group.db_dev.subnet_ids)[1]
}


output "sn_spk_prod_bdd_az_a_id" {
  value = tolist(data.aws_db_subnet_group.db_prod.subnet_ids)[0]
}

output "sn_spk_prod_bdd_az_b_id" {
  value = tolist(data.aws_db_subnet_group.db_prod.subnet_ids)[1]
}


output "sn_spk_dev_nlb_az_a_id" {
  value = aws_subnet.sn_spk_dev_nlb_az_a.id
}


output "sn_spk_dev_nlb_az_b_id" {
  value = aws_subnet.sn_spk_dev_nlb_az_b.id
}

output "sn_spk_prod_nlb_az_a_id" {
  value = aws_subnet.sn_spk_prod_nlb_az_a.id
}


output "sn_spk_prod_nlb_az_b_id" {
  value = aws_subnet.sn_spk_prod_nlb_az_b.id
}


output "sn_spk_dev_api_a_id" {
  value = aws_subnet.sn_spk_dev_api_a.id
}


output "sn_spk_dev_app_a_id" {
  value = aws_subnet.sn_spk_dev_app_a.id
}


output "sn_spk_dev_mldata_a_id" {
  value = aws_subnet.sn_spk_dev_mldata_a.id
}


output "sn_spk_dev_devops_a_id" {
  value = aws_subnet.sn_spk_dev_devops_a.id
}


output "sn_spk_dev_api_b_id" {
  value = aws_subnet.sn_spk_dev_api_b.id
}


output "sn_spk_dev_app_b_id" {
  value = aws_subnet.sn_spk_dev_app_b.id
}


output "sn_spk_dev_mldata_b_id" {
  value = aws_subnet.sn_spk_dev_mldata_b.id
}



output "sn_spk_dev_devops_b_id" {
  value = aws_subnet.sn_spk_dev_devops_b.id
}

output "sn_spk_prod_api_a_id" {
  value = aws_subnet.sn_spk_prod_api_a.id
}

output "sn_spk_prod_app_a_id" {
  value = aws_subnet.sn_spk_prod_app_a.id
}


output "sn_spk_prod_mldata_a_id" {
  value = aws_subnet.sn_spk_prod_mldata_a.id
}



output "sn_spk_prod_api_b_id" {
  value = aws_subnet.sn_spk_prod_api_b.id
}


output "sn_spk_prod_app_b_id" {
  value = aws_subnet.sn_spk_prod_app_b.id
}


output "sn_spk_prod_mldata_b_id" {
  value = aws_subnet.sn_spk_prod_mldata_b.id
}

