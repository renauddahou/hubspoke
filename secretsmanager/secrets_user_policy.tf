
resource "aws_iam_policy" "spk_dev_secrets_read_policy" {
  for_each = { for k, v in var.dev_secrets : k => {
    name        = v.name
    description = v.description
  } }
  name        = "${each.value.name}-read-policy"
  description = "Policy to allow read access to the secret ${each.value.name}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = aws_secretsmanager_secret.spk_dev_secrets[each.key].arn
      }
    ]
  })
}


resource "aws_iam_policy" "spk_prod_secrets_read_policy" {
  for_each = { for k, v in var.prod_secrets : k => {
    name        = v.name
    description = v.description
  } }
  name        = "${each.value.name}-read-policy"
  description = "Policy to allow read access to the secret ${each.value.name}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = aws_secretsmanager_secret.spk_prod_secrets[each.key].arn
      }
    ]
  })
}

