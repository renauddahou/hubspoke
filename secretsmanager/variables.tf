variable "dev_secrets" {
  description = "A map of secrets to create in AWS Secrets Manager"
  type = map(object({
    name          = string
    description   = string
    secret_string = string
  }))
}

variable "prod_secrets" {
  description = "A map of secrets to create in AWS Secrets Manager"
  type = map(object({
    name          = string
    description   = string
    secret_string = string
  }))
}



variable "lambda_secret_rotation_arn" {
  description = "arn fonction Lambda qui gère la rotation des secret"
  type        = string
}