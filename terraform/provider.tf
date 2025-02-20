terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0" #AWS Provider version, not terraform version 
    }
  }

  backend "s3" {
    bucket         = "forpracticeuno-dev"
    key            = "catalogue"
    region         = "us-east-1"
    dynamodb_table = "forpractice-locking-dev"
  }
}

provider "aws" {
  region = "us-east-1"
}