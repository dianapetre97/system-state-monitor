terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true
  endpoints {
    s3  = "http://localhost:4566"
    ec2 = "http://localhost:4566/"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
}
resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test"
  lifecycle {
    prevent_destroy = true
  }
}
module "ec2-with-ssh" {
  source = "./ec2-with-ssh"
  key_name = "aws_my_key"
  public_key_path = "~/.ssh/id_rsa.pub"
  ami = "ami-0abcdef1234567890"
  subnet_id = aws_subnet.main.id
  instance_name = "my_instance"
}

output "public_ip_output" {
  value = module.ec2-with-ssh.public_ip
}

output "ssh_command_output" {
  value = module.ec2-with-ssh.ssh_command
}