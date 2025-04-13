# Séparer les noms et descriptions pour les utiliser dans le for_each
locals {
  dev_secrets = { for k, v in var.dev_secrets : k => {
    name        = v.name
    description = v.description
  } }
  prod_secrets = { for k, v in var.prod_secrets : k => {
    name        = v.name
    description = v.description
  } }

}


resource "aws_secretsmanager_secret" "spk_dev_secrets" {
  for_each    = local.dev_secrets
  name        = each.value.name != "" ? each.value.name : "default-name"
  description = each.value.description
}

resource "aws_secretsmanager_secret_rotation" "spk_dev_secret_rotation" {
  for_each  = local.dev_secrets
  secret_id = aws_secretsmanager_secret.spk_dev_secrets[each.key].id
  # Associer une fonction Lambda qui gère la rotation
  rotation_lambda_arn = var.lambda_secret_rotation_arn
  # Enable automatic rotation if needed (requires Lambda function)
  rotation_rules {
    automatically_after_days = 30
  }
}

resource "aws_secretsmanager_secret" "spk_prod_secrets" {
  for_each    = local.prod_secrets
  name        = each.value.name != "" ? each.value.name : "default-name"
  description = each.value.description
}

resource "aws_secretsmanager_secret_rotation" "spk_prod_secret_rotation" {
  for_each  = local.prod_secrets
  secret_id = aws_secretsmanager_secret.spk_prod_secrets[each.key].id
  # Associer une fonction Lambda qui gère la rotation
  rotation_lambda_arn = var.lambda_secret_rotation_arn
  # Enable automatic rotation if needed (requires Lambda function)
  rotation_rules {
    automatically_after_days = 30
  }
}
