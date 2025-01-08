terraform {
  required_providers {
    awscc = {
      source = "hashicorp/awscc"

    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }

  }
}

provider "awscc" {
}