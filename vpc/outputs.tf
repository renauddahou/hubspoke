output "hub_vpc_id" {
  value = aws_vpc.hub_transit.id
}

output "spoke_dev_vpc_id" {
  value = aws_vpc.spoke_dev.id
}

output "spoke_prod_vpc_id" {
  value = aws_vpc.spoke_prod.id
}


output "hub_vpc_cidr_block" {
  value = aws_vpc.hub_transit.cidr_block
}

output "spoke_dev_vpc_cidr_block" {
  value = aws_vpc.spoke_dev.cidr_block
}

output "spoke_prod_vpc_cidr_block" {
  value = aws_vpc.spoke_prod.cidr_block
}
