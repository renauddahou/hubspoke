output "eni_private_fw_a_id" {
  value       = aws_network_interface.eni_private_fw_a.id
  description = "L'ID de l'ENI privé pour le firewall A"
}

output "eni_private_fw_b_id" {
  value       = aws_network_interface.eni_private_fw_b.id
  description = "L'ID de l'ENI privé pour le firewall B"
}

output "eni_private_fw_ids" {
  value = [
    aws_network_interface.eni_private_fw_a.id,
    aws_network_interface.eni_private_fw_b.id
  ]
  description = "Liste des IDs des ENIs privés pour les firewalls A et B"
}


output "eni_private_fw_a_private_ip" {
  value       = aws_network_interface.eni_private_fw_a.private_ips
  description = "L'adresse IP privée de l'ENI"
}


output "eni_private_fw_b_private_ip" {
  value       = aws_network_interface.eni_private_fw_b.private_ips
  description = "L'adresse IP privée de l'ENI"
}