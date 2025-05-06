
terraform {
  required_version = ">= 0.12"
}

####### provider #######
provider "aws" {
  region = "us-east-1"
  profile = "tomate"
}

####### resource #######
resource "aws_instance" "nginex-server" {
  ami = "ami-0f88e80871fd81e91" 
  instance_type = "t3.micro"
}