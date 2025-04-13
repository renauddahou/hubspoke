resource "aws_iam_role" "lambda_role" {
  name = "lambda_secrets_rotation_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_secrets_rotation_policy"
  description = "Allow Lambda to manage Secrets Manager secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:PutSecretValue",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_lambda_function" "secret_rotation" {
  filename      = "lambda_rotation.zip"
  function_name = "SecretsRotationLambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_rotation.lambda_handler"
  runtime       = "python3.9"
  timeout       = 10

  source_code_hash = filebase64sha256("${path.module}/lambda_rotation.zip")
}
