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
  value       = aws_iam_policy.spk_dev_secrets_read_policy[*].arn
  description = "The ARN of the IAM policy to allow read access to the dev secrets"
}

output "spk_prod_secrets_read_policy_arn" {
  value       = aws_iam_policy.spk_prod_secrets_read_policy[*].arn
  description = "The ARN of the IAM policy to allow read access to the prod secrets"
}