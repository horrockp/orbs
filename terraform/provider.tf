terraform {
  required_version = ">= 1.0" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "local" {
    path = "/app/.state/terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
}
