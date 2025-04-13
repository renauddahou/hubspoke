output "internet_gateway_hub_transit_id" {
  value       = aws_internet_gateway.igw_hub_transit.id
  description = "ID de l'Internet Gateway du VPC hub"
}


output "nat_gateway_internal_hub_id" {
  value       = var.use_nat_instance ? null : aws_nat_gateway.intnernal_nat_hub[0].id
  description = "ID du NAT Gateway privé dans le VPC hub"
}

