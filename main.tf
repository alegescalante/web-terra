
terraform {
  required_version = ">= 0.12"
}

####### Variables #######

variable "ami_id" {
  description = "ID de la AMI para la instancia EC2"
  default     = "ami-0f88e80871fd81e91"
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  default     = "t3.micro"
}

variable "server_name" {
  description = "Nombre del servidor web"
  default     = "nginx-server"
}

variable "environment" {
  description = "Ambiente de la aplicación"
  default     = "prueba"
}


####### provider #######
provider "aws" {
  region = "us-east-1"
  profile = "tomate"
}

####### resource #######
resource "aws_instance" "nginx-server" {
  ami = "ami-0f88e80871fd81e91" 
  instance_type = "t3.micro"

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
          
  key_name = aws_key_pair.nginx-server-ssh.key_name
  
  vpc_security_group_ids = [
	aws_security_group.nginx-server-sg.id
  ]
  
  tags = {
    Name        = "nginx-server"
    Environment = "prueba"
    Owner       = "alegescalante@gmail.com"
    Team        = "Prueba-nginx"
    Project     = "webinar"
  }

}

####### ssh ####### 
# ssh-keygen -t rsa -b 2048 -f "nginx-server.key"

resource "aws_key_pair" "nginx-server-ssh" {
  key_name   = "nginx-server-ssh"
  public_key = file("nginx-server.key.pub")

  tags = {
    Name        = "nginx-server-ssh"
    Environment = "prueba"
    Owner       = "alegescalante@gmail.com"
    Team        = "Prueba-nginx"
    Project     = "webinar"
  }
}

####### SG ####### 
resource "aws_security_group" "nginx-server-sg" {
  name        = "nginx-server-sg"
  description = "Security group allowing SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "nginx-server-sg"
    Environment = "prueba"
    Owner       = "alegescalante@gmail.com"
    Team        = "Prueba-nginx"
    Project     = "webinar"
  }
}

#######  output ####### 
output "server_public_ip" {
  description = "Dirección IP pública de la instancia EC2"
  value       = aws_instance.nginx-server.public_ip
}

output "server_public_dns" {
  description = "DNS público de la instancia EC2"
  value       = aws_instance.nginx-server.public_dns
}