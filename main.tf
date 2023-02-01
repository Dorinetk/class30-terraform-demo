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
#type on your terminal
#export AWS_ACCESS_KEY_ID="youraccesskey"
#export AWS_SECRET_ACCESS_KEY="yoursecretkey"
#export AWS_REGION="yourregion"

provider "aws" {
  region = "us-east-1"
  #access_key = "my-access-key"  
  #secret_key = "my-secret-key"

}
#creates the vpc
resource "aws_vpc" "Class30terraform" {
  cidr_block       = "172.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Class30-terraform"
  }
}
#creates public subnet 
resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.Class30terraform.id
  #https://www.davidc.net/sites/default/subnets/subnets.html 
  cidr_block = "172.0.120.1/24"

  tags = {
    Name = "publicsubnet"
  }
  #availability_zone="us-east-1a"
}
#creates private subnet 
resource "aws_subnet" "privatesubnet" {
  vpc_id     = aws_vpc.Class30terraform.id
  cidr_block = "172.0.121.1/24"

  tags = {
    Name = "privatesubnet"
  }
}






