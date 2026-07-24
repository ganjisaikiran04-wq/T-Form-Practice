terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

provider "aws" {
  alias   = "prod"
  region  = "us-west-2"
  profile = "prod-account"
}

provider "aws" {
  alias   = "dev"
  region  = "us-east-2"
  profile = "dev-account"
}
