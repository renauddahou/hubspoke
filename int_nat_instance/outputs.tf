output "internet_gateway_hub_transit_id" {
  value       = aws_internet_gateway.igw_hub_transit.id
  description = "ID de l'Internet Gateway du VPC hub"
}


output "nat_hub_instance_private_ip" {
  description = "Adresse IP privée de l'instance NAT"
  value       = aws_instance.nat_hub_instance.private_ip
}


output "nat_hub_instance_private_id" {
  description = "ID de l'instance NAT"
  value       = aws_instance.nat_hub_instance.id
}




output "nat_instance_eni_id" {
  value = aws_instance.nat_hub_instance.primary_network_interface_id
}
