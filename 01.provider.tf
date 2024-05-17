provider "aws" {
  region = var.AWS_REGION
}

terraform {
  backend "s3" {
    bucket = "tfstate-prueba-pragma"
    key    = "${var.S3}"
    region = "us-east-1"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.48.0"
    }
  }
}