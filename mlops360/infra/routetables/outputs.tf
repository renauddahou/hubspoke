output "hub_transit_private_route_table_id" {
  value       = aws_route_table.hub_transit_private.id
  description = "ID de la table de routage privée du Hub"
}

output "hub_transit_default_route_table_id" {
  value       = data.aws_route_table.hub_transit_default.id
  description = "ID de la table de routage principale (default) du Hub"
}

output "spoke_dev_default_route_table_id" {
  value       = data.aws_route_table.spoke_dev_default.id
  description = "ID de la table de routage principale du Spoke Dev"
}

output "spoke_prod_default_route_table_id" {
  value       = data.aws_route_table.spoke_prod_default.id
  description = "ID de la table de routage principale du Spoke Prod"
}
