provider "aws" {
  region = "us-east-1"
  secret_key = "NVIu1NyAYt5MS9fjFU7CL1Mn/wtl+BsE1rDNL0L7"
  access_key = "AKIAWHER3VJO6LEHPPJL"
}

terraform {
  backend "s3" {
    encrypt = false
    bucket = "bucket-1992-0924"
    dynamodb_table = "tfstatelock-dynamo"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_vpc" "tf_test" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "tf_test"
  }
}

resource "aws_subnet" "Subnet-tf-public" {
  vpc_id     = aws_vpc.tf_test.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Subnet-tf-Public"
  }
}

resource "aws_subnet" "Subnet-tf-Private" {
  vpc_id     = aws_vpc.tf_test.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Subnet-tf-Private"
  }
}