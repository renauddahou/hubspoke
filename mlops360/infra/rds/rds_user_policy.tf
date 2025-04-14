resource "aws_iam_policy" "spk_dev_rds_connection_policy" {
  name        = "rds-dev-connection-policy"
  description = "Policy to allow connection to RDS DEV instance"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "rds:DescribeDBInstances", # Permet de décrire l'instance RDS DEV
          "rds:DescribeDBClusters"   # Permet de décrire les clusters RDS DEV
        ]
        Resource = aws_db_instance.db_dev.arn # ARN de l'instance DEV
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue", # Permet de récupérer les secrets pour DEV
        ]
        Resource = var.spk_dev_secrets_read_policy_arn # ARN  du secret pour DEV
      }
    ]
  })
}


resource "aws_iam_policy" "spk_prod_rds_connection_policy" {
  name        = "rds-prod-connection-policy"
  description = "Policy to allow connection to RDS PROD instance"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "rds:DescribeDBInstances", # Permet de décrire l'instance RDS PROD
          "rds:DescribeDBClusters"   # Permet de décrire les clusters RDS PROD
        ]
        Resource = aws_db_instance.db_prod.arn # ARN de l'instance PROD
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue", # Permet de récupérer les secrets pour PROD
        ]
        Resource = var.spk_prod_secrets_read_policy_arn # ARN du secret pour PROD
      }
    ]
  })
}
