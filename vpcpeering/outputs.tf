output "pcx_hub2spk_dev_id" {
  value       = aws_vpc_peering_connection.pcx_hub2spk_dev.id
  description = "ID de la connexion de peering entre le VPC hub et le VPC spoke dev"
}

output "pcx_hub2spk_prod_id" {
  value       = aws_vpc_peering_connection.pcx_hub2spk_prod.id
  description = "ID de la connexion de peering entre le VPC hub et le VPC spoke prod"
}
