
resource "aws_secretsmanager_secret_version" "spk_dev_secrets_version" {
  for_each      = var.dev_secrets
  secret_id     = aws_secretsmanager_secret.spk_dev_secrets[each.key].id
  secret_string = each.value.secret_string
}


resource "aws_secretsmanager_secret_version" "spk_prod_secrets_version" {
  for_each      = var.prod_secrets
  secret_id     = aws_secretsmanager_secret.spk_prod_secrets[each.key].id
  secret_string = each.value.secret_string
}