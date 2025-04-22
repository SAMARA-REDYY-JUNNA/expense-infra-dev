terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "5.93.0"
        }
    }
    backend "s3" {
      bucket = "mydaws-remote-state1"
      key  = "expense-dev-web-alb"
      region = "us-east-1"
      dynamodb_table = "mydaws-locking"
    }
}

provider "aws" {
    region = "us-east-1"
}