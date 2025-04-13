output "dev_db_endpoint" {
  description = "The endpoint dev to connect to the PostgreSQL database"
  value       = aws_db_instance.db_dev.endpoint
}


output "prod_db_endpoint" {
  description = "The endpoint prod to connect to the PostgreSQL database"
  value       = aws_db_instance.db_prod.endpoint
}


output "aws_db_instance_db_dev_id" {
  description = "The database instance dev id"
  value       = aws_db_instance.db_dev.id
}


output "aws_db_instance_db_prod_id" {
  description = "The database instance prod id"
  value       = aws_db_instance.db_prod.id
}