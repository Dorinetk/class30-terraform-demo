terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Configure the AWS Provider
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs 
provider "aws" {
  region = "us-east-1"
  #access_key = "my-access-key"  
  #secret_key = "my-secret-key"

}
resource "aws_vpc" "main" {
  cidr_block       = "172.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Class30-terraform"
  }
}





