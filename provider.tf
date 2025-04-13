terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 1.11.3"
    }
  }
}

# Provider pour AWS
provider "aws" {
  region = var.region
}