provider "aws" {
  region = "us-east-2"
  secret_key = "secret-key"
  access_key = "access-key"
}

terraform {
  backend "s3" {
    encrypt = false
    bucket = "bucket-0924"
    dynamodb_table = "tfstatelock-dynamo"
    key = "global/s3/terraform.tfstate"
    region = "us-east-2"
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
  availability_zone = "us-east-2a"

  tags = {
    Name = "Subnet-tf-Public"
  }
}

resource "aws_subnet" "Subnet-tf-Private" {
  vpc_id     = aws_vpc.tf_test.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-2b"
  tags = {
    Name = "Subnet-tf-Private"
  }
}