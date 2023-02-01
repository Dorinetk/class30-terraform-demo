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
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Class30-terraform"
  }
}
#creates public subnet 
resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.Class30terraform.id
  #https://www.davidc.net/sites/default/subnets/subnets.html 
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "publicsubnet"
  }
  #availability_zone="us-east-1a"
}
#creates private subnet 
resource "aws_subnet" "privatesubnet" {
  vpc_id     = aws_vpc.Class30terraform.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "privatesubnet"
  }
}
#igw
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.Class30terraform.id

  tags = {
    Name = "class30-igw"
  }
}

#routetable

resource "aws_route_table" "Class30terraform-rt" {
  vpc_id = aws_vpc.Class30terraform.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
resource "aws_route_table_association" "rt-a" {
  subnet_id      = aws_subnet.publicsubnet.id
  route_table_id = aws_route_table.Class30terraform-rt.id
}

resource "aws_route_table" "Class30terraform-priv" {
  vpc_id = aws_vpc.Class30terraform.id
}
resource "aws_route_table_association" "rt-b" {
  subnet_id      = aws_subnet.privatesubnet.id
  route_table_id = aws_route_table.Class30terraform-priv.id
}

#nat gateway
resource "aws_nat_gateway" "class30" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.privatesubnet.id #publicsubnet???
}


