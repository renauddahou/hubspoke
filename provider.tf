terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      region = var.region
      source  = "hashicorp/aws"
      version = ">= 1.11.3"
    }
  }
}

