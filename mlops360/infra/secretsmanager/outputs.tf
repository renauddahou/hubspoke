output "spk_dev_secretsmanager_id" {
  value = {
    for key, secret in aws_secretsmanager_secret.spk_dev_secrets :
    key => secret.id
  }
}

output "spk_prod_secretsmanager_id" {
  value = {
    for key, secret in aws_secretsmanager_secret.spk_prod_secrets :
    key => secret.id
  }
}



output "spk_dev_secrets_read_policy_arn" {
  description = "Map des ARN des IAM policies dev"
  value = {
    for k, policy in aws_iam_policy.spk_dev_secrets_read_policy : k => policy.arn
  }
}


output "spk_prod_secrets_read_policy_arn" {
  description = "Map des ARN des IAM policies prod"
  value = {
    for k, policy in aws_iam_policy.spk_prod_secrets_read_policy : k => policy.arn
  }
}
